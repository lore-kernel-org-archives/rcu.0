Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124961FF7D8;
	Mon, 27 Jan 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984478; cv=none; b=rZaHIk5M5jOa29l6i/WQYWi8Y+vZ874rpN8et2FvYDlD6ZdJL5WAK19wKFHe67/UcdPxj7UpEdsuTJj+/tzCiPHSIPaHWKH8/DYN6fbADbywNcIp1pI6osOpx69h3fh17u3u2vQE8THVrIwYB6/bf686BlvJ4OD1E6gwG26xypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984478; c=relaxed/simple;
	bh=y96Dp6ihRvbzMEh5pUEG7/btSOZ8UyeRxpDfUeA1QYw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0WfvPuxu30fT7hi+4izQnmPgD3g8KUaT6PvClYUCKhigWaqrHzoBf18IbDxEMtoycTO04gOMPoEkPSBidy18ndHSzXr2chknuMd/q+Pp8Qzsas8bU9+M4wX8dRpWemz8yP9iYdr6ZlG/EGTqzIlEwE9gOqe+KfHZt0q2WpbRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G027Sbpt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G027Sbpt"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so4163658e87.3;
        Mon, 27 Jan 2025 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737984475; x=1738589275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKW9lEZFxUyHps/B1aQZMWnQ7XI4hml0uOetWH94NOw=;
        b=G027SbptjleuxCDzB8dPmEyJntTKnncK5AMMkdVEwMIMFa1p6LlchQufhItC9+YcpS
         LW19xoq12kDyTcuOwj611EgsTEn/vi/5Bh92H1ojKlpjaGSI2XB0Lr8oxc2rGu3Y3rTN
         i3gbRKj57gsYaYHGUIfZhzupWCPNCk6NyFG93kO7klJ3tT/ev4AL9HT4wlUcgoA60bvc
         nGJ8StWX3Oszhj/z47VrY2dzN3kkMqja0CHbyW9Af6AguJZ+ZvpfqMQ57UzvEWjAFoHj
         B2Y+Q1ZJWn/zjkqHPM/MGjFhQ6IPmELPdHMPo8GtvPEfVd1LLf9AQQ89bt4ECDY0olTK
         PKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737984475; x=1738589275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKW9lEZFxUyHps/B1aQZMWnQ7XI4hml0uOetWH94NOw=;
        b=mU2UJ3p1tt2IQ6bKmBYRbGoQYOAVs3IQWQxa89yQPE5Ci9SRSDRE+rUJ3Lp+IzXsMt
         sD7iLejVdvpZquqVha+lsP+3IAfjGowfXuhCOmEGpzkPiSnqWiNAYry0ccMgB1dtdARN
         Ax+yuSWnxayBcMVuMRNRjis7MDFxaMwcBWmfsTcYL7B7lXoXNWukpYiDS3sUc6g61ZbH
         P0A1d00wsXn4GSBSVzuC6pFmdkfLhjYMnzjZH6YK9svsLYI4eC3GoWjRl5SN6JzDWouq
         rU1r+GBUyWug4R+J7K3hW75G0QwYywV/tpeo6l/CIwLi9aTtwN7SrceGtnOzsH92g0U0
         bFug==
X-Forwarded-Encrypted: i=1; AJvYcCW3o1Ia1YXONoeDw/GkRntGrkjPo9niRb34HjlaVpAQYWOdn9v4NigeVe1MZ2Vzy7ULouOV@vger.kernel.org, AJvYcCXBKzqoNmw0G+EEcMLKtRwnGzT3dZZQb8DornhqT/zPteHJthMhwMELB/ayxWzHdbmYKybc1Or86mFTjIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyYedqFWvJ4A3M5N5lvFfM4MLpY4gECzA+5WsMV27OCaFkHlO
	YzhC/ek88PToDktHaQDzAFBElBqYG8zMsC2h7Df6Jo6upKicuaaC
X-Gm-Gg: ASbGncvd1meEjdC2zdH6tIObopo6o1LNx54GlTb+Qgg2LhqoAn6zlPiR7vMb2sHl5LJ
	y9S3tjSySFyzdIhp56YpXKp06OPETHSAtuvSi2hsZWfIRZfFDP7Bp43Ssaqx7J3ZlKO7PZTcipr
	UBdzmRyNuLw5jU3A3TWJpkhV4fnjWwPqRe11DYShSjXiVoKrN6V00pCCmldRlA9mjDSGPD6r7pU
	vM3iErUmeU3rI5ZtCmiqNPsqlxwj0Mt+LHlv2xgnd+DUy50YGFpyqNacsd50LcN9tNmF0stUBkl
	cchH9mO9HUK28X4pwXljrMZY7cwrOaCSAkY=
X-Google-Smtp-Source: AGHT+IHD7uhIzk2u6grz4rPESB/xXZ63xKkJ09nYAxNrYVzpOD9quzvLD7aQajxL861HK6OvNKN3iQ==
X-Received: by 2002:a05:6512:b24:b0:540:2a92:7daa with SMTP id 2adb3069b0e04-5439c282032mr13484940e87.42.1737984474611;
        Mon, 27 Jan 2025 05:27:54 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f7f3sm1319948e87.57.2025.01.27.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:27:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 14:27:51 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5eJ13aWwMDK00U1@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>

On Fri, Jan 24, 2025 at 11:34:03AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > > something higher.
> > > > > > > > 
> > > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > > 
> > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > 
> > > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > > and then specifying it to a number of tests.
> > > > > > > 
> > > > > > > Or am I missing something here?
> > > > > > > 
> > > > > > It took me a while to understand what happens. Apparently there is this
> > > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > > you need to know about that. I have not expected that.
> > > > > > 
> > > > > > Therefore i removed it from the configuration because i have not found
> > > > > > a good explanation why we need. It is confusing instead :)
> > > > > 
> > > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > > to complain about a Kconfig conflict.
> > > > > 
> > > > > Hence me not being in favor of this change.  ;-)
> > > > > 
> > > > > Is there another way to make things work for both situations?
> > > > > 
> > > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > > need more CPUs for TREE05.
> > > > 
> > > > I will not resist, we just drop this patch :)
> > > 
> > > Thank you!
> > > 
> > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > with RCU readers, correct?
> > > 
> > Below one:
> > 
> > <snip>
> > /*
> >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> >  * delay between calls.
> >  */
> > static int
> > rcu_torture_fakewriter(void *arg)
> > {
> > ...
> > <snip>
> > 
> > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > interacts with rcu_torture_reader().  So my guess is that running
> > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > So instead of this:
> > > 
> > > 	--kconfig CONFIG_NR_CPUS=128
> > > 
> > > Do this:
> > > 
> > > 	--configs "16*TREE05"
> > > 
> > > Or maybe even this:
> > > 
> > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > Thanks for input.
> > 
> > > 
> > > Thoughts?
> > > 
> > If you mean below splat:
> 
> > 
> > i.e. with more nfakewriters.
> 
> Right, and large nfakewriters would help push the synchronize_rcu()
> wakeups off of the grace-period kthread.
> 
> > If you mean the one that has recently reported, i am not able to
> > reproduce it anyhow :)
> 
> Using larger numbers of smaller rcutorture guest OSes might help to
> reproduce it.  Maybe as small as three CPUs each.  ;-)
> 
OK. I will give a try this:

for (( i=0; i<$LOOPS; i++ )); do
	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
	echo "Done $i"
done

--
Uladzislau Rezki
