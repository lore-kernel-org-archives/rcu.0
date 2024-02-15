Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D712CDBE
	for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002965; cv=none; b=NuXKhLKtDsNTTq15jEOMnVYvufTuYRygx6defGdOLzKrQpnMo+OtlQvu+h8ucxKdmvFc/genNl2UbbBFhPycK+C+8B45GmAmBZ20f4x49M2fLkj9/d+3j2whYp2YojAM33DX50w1zIJQPQ+engNWbbCpQ1pZkdc8UMRazM0zZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002965; c=relaxed/simple;
	bh=Xan8NJpk7gdmYlt8uNyfZqCUmsxNH9rP+xPcBc8egI0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJUfM8OGoSXz6XrAXFOwo1heiImMCw/zd9sq2ePoLhB29rpSIYIr2Y9Qz1gSTh4xkNBokeovQX2EGIrOs4lwq3TBV9WK0jZqLSVA0ptyVk7ZkEtvL3GZ2Od1a4SUl2EVzqMUpxhJtVGhBcDSCh7tCk0mLyHQCheaidIGfYIONPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HExsAl9+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HExsAl9+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51167e470f7so945484e87.2
        for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708002962; x=1708607762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64nVIJxGTdXleNWdJpJMqdJAeiz5Ven6e6W0/bkmiQI=;
        b=HExsAl9+F0s02nQs3VE3a9CjR8PUVHQwErNmhPy0UHuMcNi7qJHY4Ysb+kY0IIvPZn
         HqH9A/jUXyWmfDP1eYHMbn6dcpbuUA/jrgRFEtytWfa/i+a7lV3qEw3VVr+OSDFhV6vH
         eLIHeerMEnAjHC1tE98w1gXUGT1LUurABuP3g5LdzInGFeWTRuJbaClR0p2asmcM1W9A
         ZpME7X0vIdym2bHTgWkEb3YAYoDOId4xAGfJGi/7ZUc2kZtKKyZAcZFjTgJ/ZtKPAECR
         xUyRQPVtoHDWd1OTZbUnHE4+5v6I85oFu9E945XVqI/StjFfY6Ra2Rdy/LlC3y9iavWa
         PTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002962; x=1708607762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64nVIJxGTdXleNWdJpJMqdJAeiz5Ven6e6W0/bkmiQI=;
        b=LcGGFoMTQ968xTJLlSZ3jinOoeMMpYloBqFFE9QWoNi1EUgx8Ei0P5dyfTVCBivgnU
         fX792cyxCSQiXjpJ+dCgjJU57Qlk3XvDSPo6fK6LUEsBg0W2JQv8zJB5bvhdWUoY9xWF
         E47AkJP0rdzRGNJM0+1AdecRrYBgSNFKUs3M1rN0k6TXoia75BztSRK6dNz/PASzUHqH
         4+ap183MsSVUivI7TwWvTquU+/B7vFdLJDB8tYEufHMv8fPpas03JUwda00z2vLEAzf1
         UC46SAKm6MtxkR4Acf6vfEHFKa2kBrqoMRcuj+O3rR7JwQUQ7tVzS9bK+aD7HzLg3A8v
         gpew==
X-Forwarded-Encrypted: i=1; AJvYcCX+X3E1PWEBcXWsBf/KvSkoxXEzWsMDl99NhgL80/KMcEAEFFEnGlbb02K510cesin/G/5tx67bxzQRGal1aEzuBRCU
X-Gm-Message-State: AOJu0YxUltzJm5gFhAgqp54FrMgqAlqCU8d/NrtZQO3CysyUEFwAlddE
	DPY8LOLMrAwV5exIaQ2UHjRf8/fdDKVU6wj60RMdnCyxwgtA+gNN
X-Google-Smtp-Source: AGHT+IESglMtwR22EtNcXOmqQDFRE3orW9maAKIWKgEYjmcVq6V/oDwB2iaizzG3rfmSC0bN8j1Lcw==
X-Received: by 2002:ac2:5f98:0:b0:511:8cb2:2f80 with SMTP id r24-20020ac25f98000000b005118cb22f80mr1560717lfe.43.1708002961954;
        Thu, 15 Feb 2024 05:16:01 -0800 (PST)
Received: from pc636 (host-90-235-18-79.mobileonline.telia.com. [90.235.18.79])
        by smtp.gmail.com with ESMTPSA id 20-20020ac24854000000b005115e1d1998sm238168lfy.59.2024.02.15.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:16:01 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 15 Feb 2024 14:15:59 +0100
To: Andrea Righi <andrea.righi@canonical.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <Zc4Ojw8LsYRGzo_y@pc636>
References: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
 <Zc3CmvuD79umJXQv@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc3CmvuD79umJXQv@gpd>

On Thu, Feb 15, 2024 at 08:51:54AM +0100, Andrea Righi wrote:
> On Tue, Feb 06, 2024 at 10:44:33AM -0800, Paul E. McKenney wrote:
> ...
> > > 
> > >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> > >    return, respect to the other cases (is this expected?)
> > 
> > This last is surprising at first glance, but I could be missing
> > something.  Joel, Uladzislau, thoughts?
> 
> On this specific point, I repeated the tests with the latest 6.8
> kernel and now I don't notice this difference anymore.
> 
> hrtimer_interrupt() time is always in the range [4K, 16K) ns, both with
> lazy RCU off and lazy RCU on.
> 
> I don't really know why I was getting different results, probably some
> noise triggered by something running in user-space...?
> 
> In any case I will update my old post with these new results and I
> wouldn't consider this an issue for now.
> 
Thank you for your confirmation, so our results are aligned in terms of
i also do not see the difference and issues with hrtimer_interrupt()
duration time.

Thanks!

--
Uladzislau Rezki
