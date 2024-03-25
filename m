Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91E4CB54
	for <rcu@vger.kernel.org>; Mon, 25 Mar 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391321; cv=none; b=Nd1WxHqNVCrIe4v9teltvAEgUEK1tLqDMhy77SF/qKLXF0XcRBwZZf2TfENtRx3Ih48D4Onoek+QK/5cGLS38jfTO8aEgOTYXN4nSqyHq//HrYT+spqNDseK2ublVweZcFYexDVH/yiWXIJmc3NFFA24rIQl5b/+0V0mmsLSATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391321; c=relaxed/simple;
	bh=0HOnkjXWwiDTZizF5waT1rnlf2JjeQP7eZRutOD0bT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGt/ylk1OEwNtrUN9q7nN/TBzTMT1fgJlVo90/tjftxKiB+Ao0r3Cn8j/OjqoqjHk781F04lkqPh01rbWnQzSnEIwermWDpHo94CClmzNxLVDdPYkV4JOzn7ayIs+46PS/DClDbfdGDnYX8nIb/VxK/frRU0oq48dsjpK16W2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qi2sAHgg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi2sAHgg"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d599dbabso6116774e87.1
        for <rcu@vger.kernel.org>; Mon, 25 Mar 2024 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711391317; x=1711996117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiunE8pTzAniAwJdofUTsPhWLKKG+ApktTjbMuShmFk=;
        b=Qi2sAHgg3apWcmsNi08xOLdfTGZLDR+uH30vv+aCrp+ybMhCsiMCvIrTyoNc0lARTa
         +3Xf3dhEJUtflFpdAvNa7Ut5PK0nFSMoyMg2sXhSlXrKPxlQDSWSv8ASTE0+RbKT+SJi
         qxWyEPjhvs16mxncaY8r4X9QfxNgpQZx+VqgZNIyOs6RQpn/4sMiMxTrx22VvBUFlbmD
         SA11FVYky/5ZEs2RkEWrJN7R2Ox6+fOIswzbSBTgAUZL2C3LuhxCx6MaDSQUkqpwBI01
         FinWwR7CVubRyk+x28kV2xMzj/+VpGscxdScn3qvwmIjQlm2DSXQW0jDqJhl8QUKxoZq
         EKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391317; x=1711996117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiunE8pTzAniAwJdofUTsPhWLKKG+ApktTjbMuShmFk=;
        b=iPXyZ0Jt5F+1eoxfoQojbEdXFNYtQhTRJPH9c1ahJzw+hxoKYcoPhspuX0iGUmikFt
         u9yJbWXdeSLWyALqNGPSBakzQ2TNjmv/DdTp/uwazWXzFXieh9YSbi/mU5f0jgbUq/BS
         gopsn6Iot2EuKuxvNgSlh3jbYDDf1oOuwFb4PEh2zIs8I5pN5ckA2Lr5xQLKA9cK0VV8
         u695ascx9cr3sH9pTeJPn5VU0rcDB8fuPFQcZ0y6AO9rzkY0KjEBM1VAV2pXGStNMGBp
         tngh2lvc8tOtHPfF+V09+z1wEo0vRV5BO6e9cZafO4/GhjMNN6n3K9YSnFFZLJ8VpOsf
         pifQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1hqCoaG/9MVqZx1S2jgoQpbUdcAxyYJqdLSaYphmdvZ0x2/4osJRWDxQe1aeoUd/LMUQnDyi0imRheLP0Ha9ySNFm
X-Gm-Message-State: AOJu0YzjlwBj8pDaibTZiv0NFiSImmJzPpMRau/qgud4BtQYuj3PQgkG
	f8+jXOfXRm0AqUW7LlOXCmy7xQG6Y/Rom7hMkWbakvR9Xa2e1VeXOER2d1XR5ns=
X-Google-Smtp-Source: AGHT+IGoVm3Ms3hw3viEDchx01zbvJmITmSDfRih31jEvDnsXz7YGpYu7TX3K8XBiq6vcJl9uiKhfg==
X-Received: by 2002:a05:6512:e86:b0:515:aa18:4b0a with SMTP id bi6-20020a0565120e8600b00515aa184b0amr4057714lfb.25.1711391317300;
        Mon, 25 Mar 2024 11:28:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00a46ab5aaffcsm3320007ejb.178.2024.03.25.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:28:37 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:28:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
 <ZgGnuFJiTX5laS7c@boqun-archlinux>
 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>

On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> Also __acquire()/__release() are just empty macros without __CHECKER__.
> So not sure the indirection really is warranted for this special case.
> 
> I can add a comment in there, I guess, something like
> 
>  /* sparse doesn't actually "call" cleanup functions */
> 
> perhaps. That reminds me I forgot to CC Dan ...
> 

These are Sparse warnings, not Smatch warning... Smatch doesn't use any
of the Sparse locking annotations.  Smatch handles cleanup basically
correctly at this point.

regards,
dan carpenter

