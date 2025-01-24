Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9121ADCE;
	Fri, 24 Jan 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719298; cv=none; b=tmtDBg7BDfkRrB0d1KQWe4pWG2iJdfW3ZXksXjtZanJmir9OxWdJoa73RBseupShaBh6VFJqQj1KluLwBe0ALOnXkJ2BVE7xnMMSFSVC+eMgwvNsb7KVEdRq2YZZ+6hyIYAjkiv4b7MdN8otQz4GGxxtpF4Aqr7pklwA7y+vfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719298; c=relaxed/simple;
	bh=sdyN51v5aYB6ERkGOgvV14eWTmYxjridHBbVmoqNErU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0y5pEfEopDP5b4u2MNLp5aoVBXQCYVy61bvoJ5GBjaS8TNBpp0RJmGkIC4izLjOh5SySobcemdS0Dt0Rv9SSWkt/XzcrS0c1BgTkadLzwlHNBs9WJlc/15aIex1RZhk0LTc63MJ4Y64KJAluDAkylZWa9q/564G50qhK8/TRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9+ej95/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9+ej95/"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401c68b89eso2099126e87.0;
        Fri, 24 Jan 2025 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737719295; x=1738324095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMaR+pjNepUoWReMXMdvm2uf9T0/khbodt6eNZRD1Q0=;
        b=B9+ej95/4SL44pG9ASB7yCYuT92efthynFTw04Ptp6Gd6vPAAr7orIXZzd/7Fe4YJ+
         XtPAcW4ME1lg4Px4yLXbsZ6uM8bmB0usWn1I3JmZbBd7LxuRhaRNg3aGtih4Wc21PDc3
         p3+9SSJ5dzIm7mDCRNnU3/WH28hpQpoScLCxbc80cx1TWpheD+E32OkoEZvNmx59qlZx
         pWdFrk0cqqQRh7RMmYVuWObEQlQg9UZo60dT5Fp1QOKKlHCn/P5KkNDQ2ydcqWytA9/K
         Y/Nz35YMI7ZO9vL1+jiLneCPViXlmLqX0LMUSrSr5C37A2kknqWDiouUUSHKZtq+fbIR
         9mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737719295; x=1738324095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMaR+pjNepUoWReMXMdvm2uf9T0/khbodt6eNZRD1Q0=;
        b=Tu1+tT2BL1tHJK88Mbp0RYDOgCyMshtQm2gGWld7aMOj2Z7VKQX7ZEZG+zD71KSURX
         bcveC81BH9WnS3Vcjpbo1lI/++Pl+QW8ol1DnsNRzGGtpDpnPVfGt4bUR0h+JBNiV7th
         AFaSemdyGelLFZ/OVCgb1/uTBVg6UB5rjKcGLv1d+UOc/eohjdOIteBP67Qw3lDzonV8
         6F5uMszO+BU2PmXf6l91tnpT2CipjViVXWgTXNsgMSJOgYemu48kLBXX6IAz+aAT130C
         8b/V8KTR2ZVPjKyDtEljN1F+SoowrwN+f/XRyez/w4Z5fBGaX3gETfua2nfcQYb7Zec5
         6QJg==
X-Forwarded-Encrypted: i=1; AJvYcCVxj1J1wGGVsn9JnG+v5jmELCBITcTQgoBI17SnLBz8X1fAuGnfSIw69xCaBVWGP9wd5PmYuAFgQW6jhJ0=@vger.kernel.org, AJvYcCWNQ4XtF7f68hOYwvdV0i0Yzz/f0aSYyrg4T3ByRXq9H2IbFCLT8sahyNE/wCf763jF/kL2@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjSGgbBLcBgENK7GBr4A63guQ3eo26vstQzChw0HgR8E9FUmR
	3iiIE6VAPh/4owEr7PiPnVBn1DseFHbL8geUYsqV4ExfDEXJB5zk
X-Gm-Gg: ASbGnctJZN1QeIxpXh1iBiQtWm033MR1FwsWzHWh2/EbwBhMhqDFb8vfRYFSIO8+puD
	FetpRR5/CRqp5q2HlZy4N1ZsrWxObJTCHSirADYpfxnX9CuLoOWBys9lZlJfkihL6uWy/orb+Y7
	UVwx+flR6n4DutCqXEcaPrYQ3Pu5XymH2KYONeiJe0nKaI0ADBWwUByZ02SA61t+6WwEmqxHgLy
	R5SZeYjzvS/LY5xSw8EXVsnbHtTfq98ZxkxhZrB/GPac3iUxdMxsbnYMac6eVXetnL4yZb8ilnM
	oDozwuXqZg27BvsJtb8SeBg6WPXatXpPR4I=
X-Google-Smtp-Source: AGHT+IFCTQR5shGQiMiqSNy3cpo/saD6X8nVbZ3U+JXvLllex2UyB4L85oJaII3C9+395VGg+8ZEHw==
X-Received: by 2002:a05:6512:32c9:b0:542:7ff6:73c4 with SMTP id 2adb3069b0e04-543c7d42db1mr966587e87.1.1737719294864;
        Fri, 24 Jan 2025 03:48:14 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f8e3sm266947e87.64.2025.01.24.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:48:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 12:48:12 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/4] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z5N9_EafVhSfE6nA@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-4-urezki@gmail.com>
 <ea7d8677-f81e-4590-9716-23ea41597873@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7d8677-f81e-4590-9716-23ea41597873@paulmck-laptop>

On Thu, Jan 23, 2025 at 01:52:57PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 23, 2025 at 07:58:28PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair for debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period
> > is passed or not might lead to a false kernel splat.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcupdate_wait.h | 4 ++++
> >  kernel/rcu/tree.c             | 8 +++-----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > index f9bed3d3f78d..a16fc2a9a7d7 100644
> > --- a/include/linux/rcupdate_wait.h
> > +++ b/include/linux/rcupdate_wait.h
> > @@ -16,6 +16,10 @@
> >  struct rcu_synchronize {
> >  	struct rcu_head head;
> >  	struct completion completion;
> > +#ifdef CONFIG_PROVE_RCU
> > +	/* This is for testing. */
> > +	struct rcu_gp_oldstate oldstate;
> > +#endif
> >  };
> >  void wakeme_after_rcu(struct rcu_head *head);
> >  
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 2795d6b5109c..0ae90089ef09 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >  {
> >  	struct rcu_synchronize *rs = container_of(
> >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > -	unsigned long oldstate = (unsigned long) rs->head.func;
> >  
> >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > -		!poll_state_synchronize_rcu(oldstate),
> > -		"A full grace period is not passed yet: %lu",
> > -		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> > +		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > +		"A full grace period is not passed yet!\n");
> 
> Looks good, but why not also continue printing out the required
> grace-period sequence number?  Yes, there would need to be helper
> sprintf()-style functions to paper over the difference between Tiny RCU
> and Tree RCU.  ;-)
> 
Uhh :) Do we have rcu_seq_diff() for a _full() API? Looks like not :)

It contains both, rgos_norm and rgos_exp! Take a delta of both?

--
Uladzislau Rezki
