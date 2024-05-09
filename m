Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E677323D
	for <rcu@vger.kernel.org>; Thu,  9 May 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237212; cv=none; b=Iu0ogaiwPqgTr8litzERMR6oxhyt9naBCjtIAPHs1HhNZqMXlplazylwLveX7zXRC2KTR2joUvEZ0sT+ZIfstb/T4YIkJsAkMDUb4NX8qMkOKJ4EnDTGQ+qctpc4/PTaQemY060N5ghHmdo0f9lOfUthTmrLUjeFb495Wjtka1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237212; c=relaxed/simple;
	bh=tYDHbw/J5RGY2hztsk6nq2+exd1n1A6YD7L8nVMPp60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdhrGX+eg7pBXOwMmGn47VQ8Llviq8nkN+80B+BSRFiWb5JXZfGqAODxpGjjCu2eV9O4KPG7psrmN3d0G1/4CVT8OdXkQt02FfhRfiUY0QmxHV/w+IlSkPWvLtx3UwvqkbWUTfBPnxqnLMSU+w9J4mVPP5gHniF5/fgZlzsSrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXIU679L; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXIU679L"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e428242a38so6486051fa.2
        for <rcu@vger.kernel.org>; Wed, 08 May 2024 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715237208; x=1715842008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZVKaQDvM6RTEm7D5MVsyr5Jj5pOb2aiqI2AUrBZk8I=;
        b=OXIU679LTOUt+eWUENhieNDTXzTNujrh5ubQpp+2rCXN5umlwlWlY7mISrBdvwCtml
         UEM7ZnLOg9ekBAb+F231ip9gjeLCS8gGqY9gn2g3pW1OYaGKBsXxx+0tfgYgeD6gog5O
         Pifqz3FB/lly+wdDp0apZWy3jPIt5yZCmb2qzlGXP0Gpc1g4C5Yc5ufBlKiLExz1uFEV
         Hlu5fHg8ZKTndE3DifpqAsBvEFO+ga4Dmnd8pc2ymb98+sYMknCqvoCZ3NmQYVD6ou2Z
         WGb/l7BId2oPsNR0cCvXS9p/xFlMUSXrk7LEfA1QJbUwuRDyr7rQI6i2mwudVbnSleWX
         RviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237208; x=1715842008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZVKaQDvM6RTEm7D5MVsyr5Jj5pOb2aiqI2AUrBZk8I=;
        b=Wro8LNUv/bsVyk5stWhDiBRh3MXOJ0pEpnbN3FWjZoDhNvPpBYVXXraN/PxrARrLZc
         27YNgtKgY8n6Rb5oA5uShUySOaPgtGwEflbiteep46GlhJy3I+e5uLtbuRUr9l+Jay/v
         f4tNxW07tUS1JZLxAHj4jLXaPG4XEwOBRgMxBqc/Jk9O3qIMIyi63m7eTYRcYOODQrz5
         Qw44n5T6YNeOyEViQbnhg0mrs/9J/RpWSEY9XRkydWuQpe3JxdJCHxGE7sNEc+Vhtr5b
         d873QNdjXkzoICcrfr1GqyduXZadfhKQOfwzoeU3tH0A6MQKgjB4q0h8cUMRhtwo/lEs
         sBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWgKkhsH4z5kLTXWqB4RZQpmvEz2INnFBA4IaPaoYaeknajQh+nJ/NkNfgCfJeELtKX2PUGNXuifRX19XFmWJzRQwBj
X-Gm-Message-State: AOJu0YzPuwokYZhA2bXcWilp4rWAAXgSCHiuSmnryG4sv/MAChqqGGHS
	9sCIfMUqaHy1w3Lm2CL3HMya30OSqf2IAgNKNC4Km0dLJ2KUdREwgTmW0ZXXEeA=
X-Google-Smtp-Source: AGHT+IEnzaYfswIcWRG20HcDb3QOtnBenvBMmMRGDpa64wpFgETxCRr73h+Joas864uRcaaQYM6fLA==
X-Received: by 2002:a2e:a314:0:b0:2e1:9c57:195a with SMTP id 38308e7fff4ca-2e447699583mr41532491fa.32.1715237208183;
        Wed, 08 May 2024 23:46:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17891fe4sm40428366b.55.2024.05.08.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:46:47 -0700 (PDT)
Date: Thu, 9 May 2024 09:46:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <2978272c-1054-4f33-a31a-8cece512cc55@moroto.mountain>
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
 <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
 <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>
 <e775bd83-dfa3-4f09-9539-e0e655feda08@paulmck-laptop>
 <2a5bc6d1-c45e-4cf2-81bd-49b55caa1478@moroto.mountain>
 <c18678f2-dff9-4d2b-9079-d77ab276ccf2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18678f2-dff9-4d2b-9079-d77ab276ccf2@paulmck-laptop>

On Wed, May 08, 2024 at 04:50:46PM -0700, Paul E. McKenney wrote:
> On Wed, May 08, 2024 at 08:38:06PM +0300, Dan Carpenter wrote:
> > On Wed, May 08, 2024 at 10:32:43AM -0700, Paul E. McKenney wrote:
> > > 
> > > Agreed, and please see below for the proposed cleanup in this case.
> > > 
> > > 							Thanx, Paul
> > 
> > Thanks!  Did you see the other warning I mentioned?
> > 
> >     kernel/rcu/srcutree.c:910 srcu_gp_end()
> >     warn: mixing irq and irqsave
> 
> I did, but then I promptly forgot about it.  Thank you for the reminder.
> 
> > Btw, I'm mostly sending you these because I know you're interested in
> > these sorts of cleanups.  I didn't bother sending one to aacraid people,
> > for example.  :P
> 
> Maintainer's choice!  ;-)
> 
> How about the following?
> 

Thanks!

regards,
dan carpenter

