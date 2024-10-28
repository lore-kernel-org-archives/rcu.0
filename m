Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D441D6DA9
	for <rcu@vger.kernel.org>; Mon, 28 Oct 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101995; cv=none; b=lEjKgtH6g+aDNZ/OsNY67AmkguR1vAvFtx7jCOQ+TCVlZbwhJ0RRIgrN27mj1wy0favaYoEZ5pn4cfndvS9HRPYFNLJXj897xu61iXuhbGNlqgvpGKBFGihNPq+HI8BDawL+fJC45xW3++7mcNJgJn+oPwXCqNXBe69rAArnH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101995; c=relaxed/simple;
	bh=MtFvMBf1R5MacKSFPzT7E5Q2YkdjGI5UyHr7ZiVHSJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpIZtoDzEpP087nKjrAEFl0/D75uq6X2j3etFJm4huIFIH6+8JE8R8abZ6O8By0wHRrVBX+vhTg4X5nT5QaTAcWFnJFLyIglC0P7wsn9MMlzKSSVHYD2z1vU8abkmKZ+BRRu+Y95DoG26WGHaecjKxza2WLKj8DQrFTPCpC67wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqJ4ygwo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqJ4ygwo"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539983beb19so4647400e87.3
        for <rcu@vger.kernel.org>; Mon, 28 Oct 2024 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730101991; x=1730706791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnHxzLN/eo2sSdXR2G6+XYTD282XEF/60QtWiUSimzU=;
        b=oqJ4ygwoTTWI9V84qcbCpNIaX/0jh4z/JlYAd1lRcnWr7/bjp/BFkTlbAl053NgDup
         DybJmg1FWDRnstS9w8OsmiAJDld4Q/mXm213FASDVHYArt2ILMOh4MFvR4pBopXpVun+
         74VNg6nnK1KbJhbcIY4ruevehhbl5CPBq+uiA9CTI/lnqBcXDn2/yEs/ZeB1hlTfnBUm
         3CFvMSJ8UmPVKMeDLRhRcC47SW5aBMxlnEK/w/MiF6veIhz8oofsrbKG0j4ONveidLl0
         1X5jWG1ITW6HcYxdPa+qVyUojIuXZSA8LnKw5navnMCKgNNKeXaNz8GXXrVX5hneTKRb
         ijEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101991; x=1730706791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnHxzLN/eo2sSdXR2G6+XYTD282XEF/60QtWiUSimzU=;
        b=Xl3VBuKXQGNIfJC3NGlkfShhpsgfJ9BFt6A8wWWlGyPbbjJRIpHDMd7Q0Uhxyzbd1t
         psW83XeKhRX1Mmb8N1QJluQxUG9xvyAVl9vXjPvNfgaMES834OSioeY8oBx9DlQXAb3z
         ZtcSwVyPF87mZJyzXBioR0XexXjsbYpBI+ORL7HefgpKQJd3okdxyumrUtwZr/Jkn3E4
         R1564OB7ypHYNHkmR50rfF3repglCS7Ghk1kG0cCyrcmUrIJB3tekN+K8sTdakB3XSzS
         +DQRhbMRczkDG4p2R6wtiQWSxwDIgyPkoja16IlWj0lTfEnhhNmzu8rbnUFSijaT/zG4
         Bryw==
X-Gm-Message-State: AOJu0YwzQxs+13bZgGWQVOMl3PGN2nKAg1pJ/Y2pW27t8dMlUD4All4W
	shpZVl+aOe3WhwBA50SFZUi8BFDlmM8g6fCBmcCSOcl/g8U/bdJURXprC3deQo6ZThY6+0G47wU
	tI9Y=
X-Google-Smtp-Source: AGHT+IEis1Og55ZKWwVUB51gZ5nuU4KsL+tGsXzjEv82lDEzeY7IC6C9kbHAcubBrvF2XhqsB5OA6w==
X-Received: by 2002:a05:6512:3baa:b0:53a:a26:5690 with SMTP id 2adb3069b0e04-53b348e57d1mr2345393e87.34.1730101991111;
        Mon, 28 Oct 2024 00:53:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b91d36sm8675546f8f.95.2024.10.28.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:53:10 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:53:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: [bug report] refscale: Add srcu_read_lock_lite() support using
 "srcu-lite"
Message-ID: <9a6fc4e0-cc52-4c0a-8e45-edafc668a2d6@stanley.mountain>
References: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>
 <08a3a25e-0c83-41c1-ba07-db3e2c9ccf19@paulmck-laptop>
 <5b5e9db9-5253-4600-acf4-8cc8a5825030@stanley.mountain>
 <c8d5c0ad-9061-4e85-bd84-c5f8706d148a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d5c0ad-9061-4e85-bd84-c5f8706d148a@paulmck-laptop>

On Sat, Oct 26, 2024 at 06:12:21AM -0700, Paul E. McKenney wrote:
> > > commit a489ef720efa78763afa39fe88d09dbb4176a47d
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Fri Oct 25 17:55:29 2024 -0700
> > > 
> > >     refscale: Undo j/J vim mistake in ref_scale_init()
> > >     
> > >     This commit gives each of three statements a line of their own.
> > >     
> > >     Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> > > index 7770e202d1ea1..7e6472a86dba8 100644
> > > --- a/kernel/rcu/refscale.c
> > > +++ b/kernel/rcu/refscale.c
> > > @@ -1182,7 +1182,9 @@ ref_scale_init(void)
> > >  		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
> >                                                            ^^^^^^^^^^^
> > This for statement is messed up still.  :(
> 
> And also a nearby "if" statement (finally looking at the offending
> commit).  With the addition of the patch shown below, are there any more?
> 
> 							Thanx, Paul

Thanks!

regards,
dan carpenter

