package com.minhyuk.common.advice;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.dao.DataAccessException;

public class CommonAdvice {
	protected final Log logger = LogFactory.getLog(getClass());
	ResourceBundleMessageSource messageSource;
public void setMessageSource(ResourceBundleMessageSource messageSource) {
		this.messageSource = messageSource;
	}

public Object logging(ProceedingJoinPoint joinPoint) throws Throwable {
	// TODO Auto-generated method stub
		
	    String className = joinPoint.getTarget().toString();
		String methodName = joinPoint.getSignature().getName();
		String fullname=className.substring(0,className.indexOf("@")) + "." + methodName +"()";
		Object returnObject=null;
		
		if (logger.isDebugEnabled()) {
			logger.debug(messageSource.getMessage("loggingStart",new Object[]{fullname}, null));
			Object[] args = joinPoint.getArgs();
			if ((args != null) && (args.length > 0)) {
				for (int i = 0; i < args.length; i++) {
					logger.debug("Argument[" + i + "] : " + args[i]);
				}
			}
		}
		try{
		returnObject = joinPoint.proceed();
		}catch(Exception e){
	if (logger.isDebugEnabled()) {
		logger.debug(messageSource.getMessage("loggingError",new Object[]{fullname}, null));
		}
			throw e;
		}
		if (logger.isDebugEnabled()) {
			logger.debug(messageSource.getMessage("loggingEnd",new Object[]{fullname}, null));
		}

		return returnObject;
	}
	
public void afterThrowing(DataAccessException dae) throws Throwable{
	logger.fatal(dae.getMessage());
		}
	}
