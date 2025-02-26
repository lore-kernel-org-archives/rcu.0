Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDC21171A;
	Wed, 26 Feb 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580157; cv=none; b=tuu2dZzDMuS9zAmYfISzbYirMa0vQKZ3i9yHK94IJRa3/nKvp0Cxb6YHAcJvo6XYloKsvS3sVvGOCTPJnzAWbOJXYfHVUJdu+aGjiMo1cShXhEWEqqgnzieeojLCy/Wzkl2WADvLK6+3aZddUsLOPiU/87ffqfcArZHoIrjYOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580157; c=relaxed/simple;
	bh=U3XRu9BKSm5XctFw50gAsIGx5i29PiCx3IkvGID+i84=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUYUH3sMvhf3rR/mQ78EP3Zz5oBACJKgSEKuMLwuvhYQUShnQHH3u3D3bXT5TaFOZugEQS3dEoo5D2lT89AaloxQcy08I5p4LFqLOctc4wDXigSrc+6qsl5ELzR2jWyBqcjVvxG4SW+1ETkZ0P5EO0bF96EXb64hUcYEYKQXgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOt/uCgm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOt/uCgm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so7852115e87.1;
        Wed, 26 Feb 2025 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580153; x=1741184953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2kiu/HsUSKw59lXGQxuGghGnHIXAC6zHsBsQ9Wyn90=;
        b=WOt/uCgmB52JDNqvMqBaxDvo0DLTgMguPGtyUm/n5XIgK7pBF6lSvMNxpH06awe7bK
         fJpTNQ0gbIj1hyZmdEKYBZezvwFWf9vhkzk8y+Q6uzfvK9TaogVXsswB7hX/FYqU7DDh
         uc0bDQXzAwvVN4Of2G5+2Y9V3BrrmQGuqNga9Oir/mXZqLxC+kgtRMmU9FFy2cg48KMk
         bJCJ7NhPi37bAXxyxKuxujc2e7s6/5V7Pivz0DSHcAzKIr+wIxklQevXnHcU5EEs3P5Z
         bHEwgj2J6nXW15OFpnMb2HcgphKcZhoLwZQhFbWHxavPrVCHJz6e5GmgLGGcKJ9qPaUY
         bhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580153; x=1741184953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2kiu/HsUSKw59lXGQxuGghGnHIXAC6zHsBsQ9Wyn90=;
        b=KzGLpYanAsaaAMLMci1OPmTDf1CQD5zQ52kwIRUy/guVlu0XAfYGRkBbs5JojyUTGI
         8hBHbH/5N7E6+VgOB08XskavYrlO2StnXTCrHovZq6DtjdLNEH9oFdgN7suCEhMnUMyL
         jqhuzUMSbmbK0FZhnEyiSpa4jhW324foDap+2UeTHd5KXM+NE+FbNstV1X3Z1t0XMHbF
         tXZeOeKOElwcCErZj3fPtyy5cTlZqQCud6n2gQpVLvNMCZ5oqFGLcDIMWU96nGSji2fX
         rM5AOg7Kc1+kmKnWqFOfSVGGTAzVPwJSOLBpBJEg1iMfxU4egWEIeNHLUUI9dEIo4NHf
         DUHg==
X-Forwarded-Encrypted: i=1; AJvYcCWJr7MdqhQm7TK7ja55aXe7tueRTg0PpjwzAgcId2dBgkRUgqVQJJFF525SW4GqpGZXSsQmw0/imO30YSo=@vger.kernel.org, AJvYcCX84ojp5EdXVtGOjAsPJzkA26BD/e2RGhMOLvw4GROc64JqzhxjQ5smVoCyz9ygRcxtq8X/@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWpPvEFzqJEyrAZg8wySEXvvkk79C8D1kozvZwXMWtuOSnBAo
	Dx+0WZdQxxO6mRhU9JoR68Hm1P6MeSClimxORsjZLyApWocg+aH9Wfq8/GNc
X-Gm-Gg: ASbGncv33g/XUVBXjyi/zoBXXV+gTU2VabVTCL/dK/K5lIPT1B+1CCDHSAeDLn5L/Lg
	kMqUQr1k1Y+bxYIyKC75AIxFvbF7BCMc1sPm6vcTKxHuh4DlzdIT9e1wj6ktRbi/gWTbA/aEnn0
	ebX1i5jjL+FoOx99f+rE2QQf1gBdmdOU7hb6mavfeNLzeOppaRIa5WE+GlTLLEoDgkDc6ozih8l
	oEHbi2DHeSL9eoNGJIlECR3Kr3/ostOuZqlUAUc0RlY3UR5Qf1if9lkPf/eaIIXWw+zMSNUwALA
	NhCn3r2lV0SL0zixJBubl6DjCNNJqwsZnsXl9EgBV4YnlDlN
X-Google-Smtp-Source: AGHT+IEwjEWmxx978qjGI809JUeWj0qQG87ubxYGrnt++ojs9L+/TlCz0ZiMFqjIWL2+srJwoWhmfw==
X-Received: by 2002:a05:6512:3c99:b0:549:38eb:d690 with SMTP id 2adb3069b0e04-5493c5c11b5mr1910652e87.36.1740580152930;
        Wed, 26 Feb 2025 06:29:12 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548b3fc7a07sm391300e87.20.2025.02.26.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:29:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 15:29:09 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <Z78lNRKjLQKigyLw@pc636>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225212409.GA1807836@joelnvbox>

On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
> On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> > Currently "nfakewriters" parameter can be set to any value but
> > there is no possibility to adjust it automatically based on how
> > many CPUs a system has where a test is run on.
> > 
> > To address this, if the "nfakewriters" is set to negative it will
> > be adjusted to num_online_cpus() during torture initialization.
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d98b3bd6d91f..f376262532ce 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
> 
> IMO, this should also be updated to reflect the possibily to set it negative
> and hence to number CPUs:
> 
> torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
> 
You can set it to a negative as well as to number of CPUs or any other
number.

--
Uladzislau Rezki
