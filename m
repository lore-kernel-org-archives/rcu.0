Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6A8003F;
	Thu,  8 Aug 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133544; cv=none; b=Pc/jmjt1YAFoqvs72OBBIabzN0P4QaKXKQBY+IhXXLjIomBpib11BRW/2DTDFq2YN3F4FoGjoCqR1OST5MLi2pd8dtseo1PqeESz03bYx4rUwTxclOSMQ35Xtms+gTBg5o4PBo+sjnjZbhS3xvduG+ztUZc52UcZg9h7XCSjSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133544; c=relaxed/simple;
	bh=NPcCWE9JDf1UNWxBSJvokap4mHWY+/gUsMv0AVn6jrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkycZOw9B5fMqe1tcmF2l8WDaGH9MEAbZ2OGFP+3jzsC1x+r/pn0Cu39L5qoLeFUuXhGEWDWoQ5fia6CGfHbYQSyco0fR2AVAzZXg7M3r/2ER4/KVqLd+dd1H8f/Sfo39X0xivnhFA+t7tI3ifXUXcSZt5HZ7IoiuSwtk8tq+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy/eunAM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy/eunAM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26106ec9336so546435fac.2;
        Thu, 08 Aug 2024 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723133542; x=1723738342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwjAxdVOY0pC/qoBsDNK4asfEsMb6nFG73VzDaJ5Xes=;
        b=dy/eunAMiQh7CP8p2nIVnQQ9g7QN7CsaLztW4Buad1bbD9VGe2tEXsZN09LpxyA/Ci
         BawCXjd0it+9fsMWUaYWe7elJrfiy0KkNesnEwMQHZCXKuLbEXTL4p93ERVa37+DIfVz
         dTg5ibPVPvfmLcG9GmDTGDY/rsJfYnF7qBORg8DfOJKEwFaLF7V+BvpDs4GdXjQtu13U
         dqCUWdzzdqIBAd6G0NzCECrYjQZ3OTemNHhn0qx/5RMxoCFcMee1VQk8viP/AUEW0CND
         qkoRT11RG7HwgRhtJM+N9wHIONOzfANKzv62cUVOeczX+JIpwgzo3uWX7yK/1WknW18u
         KLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133542; x=1723738342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwjAxdVOY0pC/qoBsDNK4asfEsMb6nFG73VzDaJ5Xes=;
        b=gtMI5GQs4ZMoez5gilc1fsrPqgocouCmb0N1dBP3JywtEpCj78nqEjtmdsUAGsK0O8
         dkWr2XUD8ZL+OIgQfjYOLPvPvtbdQpmjKJAWoe1kcXhfiOjxJO5HllQZ1/z4CWrSAtyV
         AEE7QTdvuFUl0W7Czk+j1IQjbO5Qp7z0PsovL29Qv4JK0p3LrYV0bsWGVPpKlmKSn7LK
         CeTWL0v+YvgFBZrGANqJGRc+sSIbggjKy4jS098wRh8N1oGp7A7wMrbeN+IjtboAznHW
         ClNMxMt7opojvWjV85uMIisuZTowuHSi/SE79WthrSJVx56O077TK+gmqnd7VcQrSkkE
         Kx2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ks31KWhIb92NHWWx/izGzfPewrKo06o9GCbEvk1SseFdfnvgIzPd0PJX1muHJUQDsI2qmHIIWdtPHjMym6f8otbON1I7SZEGykNiFMHLCsILjhIA7lHwX72YA+mwTMkA
X-Gm-Message-State: AOJu0YzrkR0tUy0RjqdvMpbUUcth+ObJAeJ6K1JJw1YkskSA5wt/TPzq
	wJiAbzpX/GGNw3g4wlAg7rW6PSNax8YSWSBk8KcR9Ryka4xcGY6+vwPx3A==
X-Google-Smtp-Source: AGHT+IGrBMRECOobD5lzJn86Kl6mqTTovGDMo+mfEWyVCm52JzFNgCvXhD/7xWC0tENc9UzLDdGEoA==
X-Received: by 2002:a05:6870:2105:b0:260:f244:a0ce with SMTP id 586e51a60fabf-2692b218157mr3032944fac.0.1723133542326;
        Thu, 08 Aug 2024 09:12:22 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d2a8dsm173956385a.10.2024.08.08.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:12:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 79251120006A;
	Thu,  8 Aug 2024 12:12:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Aug 2024 12:12:21 -0400
X-ME-Sender: <xms:Ze60ZjBnModWA-A8GcPnlapQCNIO_2rYkFbs479ZbcoGZN37SozOzA>
    <xme:Ze60ZpgrYeFgPRBNDAJmTkJhywye432W0bQdc2UCWGjw2RZ8emVboPk5Z9NYrJ61c
    0MK5el91YtXUMUEtg>
X-ME-Received: <xmr:Ze60Zul3CjswJ2Ts5na5CYeDb5BEIxeOMOnOPPGQceGXAq78Z5Kimc-n8as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdethedu
    udejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglh
    igsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:Ze60ZlzQ32i2OOocdnvCyM8b2MTDtB0qOEMB2-gttMI22qapQogG8Q>
    <xmx:Ze60ZoQjktV9IjL4dU4bp_Ib2yg0y7VnX7FiKagPa4BJi2YdDHw6og>
    <xmx:Ze60ZoZTuPHkdvs9BKwYpbo3vshEFvyFErEFu28-oXNZhSTXq1zt9g>
    <xmx:Ze60ZpSFqyx6hoTIW4MhYKE-J4Vso77gqLYZljnxBy-KaOSfnPPTtQ>
    <xmx:Ze60ZuCkK6QpEtJR7m4SbMlfcWSMofU_Nlvxq8O_yjacexDp0U9BxLfK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 12:12:21 -0400 (EDT)
Date: Thu, 8 Aug 2024 09:11:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	paulmck@kernel.org, frederic@kernel.org, josh@joshtriplett.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: [GIT PULL] LOCKDEP changes for v6.12
Message-ID: <ZrTuINZIQhWuB7s7@boqun-archlinux>
References: <ZrQ97Zz27Tzmr0Zi@tardis>
 <20240808101939.GG31338@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808101939.GG31338@noisy.programming.kicks-ass.net>

On Thu, Aug 08, 2024 at 12:19:39PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 07, 2024 at 08:39:25PM -0700, Boqun Feng wrote:
> > Hi Peter & Ingo,
> > 
> > Per discussion:
> > 
> > 	https://lore.kernel.org/lkml/20240802151619.GN39708@noisy.programming.kicks-ass.net/
> > 
> > I'm sending a PR with some lockdep changes to tip.
> > 
> > 
> > The following changes since commit d5934e76316e84eced836b6b2bafae1837d1cd58:
> > 
> >   cleanup: Add usage and style documentation (2024-08-05 16:54:41 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux tags/lockdep-for-tip.20240806
> > 
> 
> Right, so a few things for next time, could you read
> Documentation/process/maintainer-tip.rst and make sure patches more or
> less adhere to the things outlined there.
> 

My bad! I will definitely do a better job next time.

> Things I noticed in the few seconds I looked at things:
> 
> Subjects don't start with a capital letter after the ':'
> 
> The Changelog for the lockdep-vs-rcu thing can be much condensed by not
> including full stack dumps but only the relevant information.
> 
> If you don't want to edit patches by hand, you're free to push back and
> get the submitter to do things before applying them.
> 

Got it.

> Anyway, since I'm about to head out to the beach, I'm pulling this. Also
> I need to figure out how git works with remotes and tags... stupid
> things :-)
>   

Enjoy the beach ;-)

Regards,
Boqun
