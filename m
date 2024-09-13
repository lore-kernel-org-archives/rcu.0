Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9F1D58A5;
	Fri, 13 Sep 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230285; cv=none; b=mGGMYxUuW9IiLSB4zGg2PUCtKPdoz0eT0SPRWYhy3Dc0+0qbG4CciKc0xWCd8P19PY+uKJBlqOwU4tni2yczBQE0Ab3Y10lBZwEJ72kTFODuUepbJtWBEwvtsAk9+MslhOEWjIWmaz0TP4stJGlNHrkv5ew38HRrmHYI+IIm9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230285; c=relaxed/simple;
	bh=VmINIj5NH1MZ4e8FN/wTEV756SmmHNn3Op3QNsfyjls=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrp9J/eO6XIpCJG4de7iHc/3ZzBxMSETL6g4DTXhjcKjpN/ZpH6Jy2GCNs2LtuxyYQXspaLSoScepNZdPjJ26hpTo4C2nwRyQp3xrgsaVu48ivxyKMvCrJucD0dyiW6MCE0pfs8Y5docbfyNav2+CXxvfcg3is2IO7du5gj3XGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecH63PkR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecH63PkR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5344ab30508so2821646e87.0;
        Fri, 13 Sep 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726230281; x=1726835081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFPRKDqHutsw2IRFpZNgYHQw3hG+kN8M0uPbw2n2aso=;
        b=ecH63PkRQcOxZUNBRm9xuob34EJDWvRZTIHPFOiKYUeaFOQMVVoMJ+fFZ0oAd1jjyh
         SvXJsC1nVEyi+zhOMYCYVr1hF1n47HqPQgEmNJqMVobzVJKqoVz/mY905KQsqMkp9rg1
         ckYICMfLyO5X8GFER8SdUTzVIZniZRxaaSYOjNEf9qZJoOMDjk8Eht4KCHip2WYdhOXe
         bQDaF2llEAlcbTigjJnweTc3MgA9goO3+r8t8xcWr/3ALBqXPiM5Tc1xIlAh/US5kgbz
         jKeJjxYVMAPOPbI5cMKfb7anMz6+THVO6mzbhMJyZqu2L6q7MzoJSx0ke6oetq196msN
         KwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230281; x=1726835081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFPRKDqHutsw2IRFpZNgYHQw3hG+kN8M0uPbw2n2aso=;
        b=VPgcqrhQVMciOna15murnv9oHSCefgD9ZXXj2IW3BlU0J2JCvFDluFv4VBgPiJQydd
         yPEaXDhfXqBG0baKdFFAdClD6pLr9IGNrYxMyCbpY5gZqsPG7EoNSX9tMU74AbweOErE
         oNWLfXIh6gUxwFLwv+taq/qB7syH+VIoZSXZ+aiRSEKIFAzr5e24d5YMHj/NhjCcsfhK
         LZ7pfOUWTqSeuKSZWQm8xwXcngAnTv86iKfEbdz3LudIcuZDjoU2YYsDMQRcaqAIWUD9
         GDEe/WGiXhW8QFn/znVNRuh7TW3k96BfYwegAg2n/nFOpatiHZ9zfuRkTnu4kP0sCZKo
         dZhw==
X-Forwarded-Encrypted: i=1; AJvYcCU0sEW7RJJ0Z/Kvnxzmfz8qFwPf2u9TzHOlU9o5sxq4TFcbo2qmL5BZZEzFzJ5sZ6yf1f1h@vger.kernel.org, AJvYcCUJhvxcyApAxK7O/bXh2DydScDEvK1scZtKqXn2nkUJwgHQpVjTMi1g6DAtXtORfcAIwQyb4ho0GYxOI44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoZ0wmN4cPz/7KrnHwoXhJoCDd7SERxpjBysm0+pfZk3LXdvP
	H0521lMY8a9WkXB0DyEpLflx7a3HzNWT+vHIPcckqSkPv4Qiss3W
X-Google-Smtp-Source: AGHT+IFLUQoibGRDw3oUS7udJsaqOPVQtkIi5Ll/wCSUkCxyjdP/Pv8MsS4CR3z0bme5UUzSOSH3Iw==
X-Received: by 2002:a05:6512:3d93:b0:533:32cf:6420 with SMTP id 2adb3069b0e04-53679075a23mr2093293e87.8.1726230280647;
        Fri, 13 Sep 2024 05:24:40 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d429sm2277066e87.263.2024.09.13.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:24:40 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Fri, 13 Sep 2024 14:24:38 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZuQvBjqEtVus7rGO@pc638.lan>
References: <20240820155935.1167988-1-urezki@gmail.com>
 <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>
 <ZuFmWuUK8POsihzf@pc636>
 <cdab7aec-0f03-48ab-b162-28c4a2f198eb@paulmck-laptop>
 <ZuMT-IpkBCGYzIIL@pc636>
 <4c3647a0-a6f9-40d7-b214-7497af104181@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3647a0-a6f9-40d7-b214-7497af104181@paulmck-laptop>

On Thu, Sep 12, 2024 at 11:07:24AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 12, 2024 at 06:16:56PM +0200, Uladzislau Rezki wrote:
> > On Wed, Sep 11, 2024 at 03:39:19AM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 11, 2024 at 11:43:54AM +0200, Uladzislau Rezki wrote:
> > > > On Tue, Sep 10, 2024 at 08:42:54AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Aug 20, 2024 at 05:59:35PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > > Add a kvfree_rcu_barrier() function. It waits until all
> > > > > > in-flight pointers are freed over RCU machinery. It does
> > > > > > not wait any GP completion and it is within its right to
> > > > > > return immediately if there are no outstanding pointers.
> > > > > > 
> > > > > > This function is useful when there is a need to guarantee
> > > > > > that a memory is fully freed before destroying memory caches.
> > > > > > For example, during unloading a kernel module.
> > > > > > 
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > 
> > > > > As a follow-on patch, once kvfree_rcu_barrier() is accepted into
> > > > > mainline, should we add a call to kvfree_rcu_barrier() to the
> > > > > rcu_barrier_throttled() function in kernel/rcu/tree.c?
> > > > > 
> > > > > This would allow the do_rcu_barrier module parameter to be used to clear
> > > > > out kfree_rcu() as well as call_rcu() work.  This would be useful to
> > > > > people running userspace benchmarks that cause the kernel to do a lot
> > > > > of kfree_rcu() calls.  Always good to avoid messing up the results from
> > > > > the current run due to deferred work from the previous run.  Even better
> > > > > would be to actually account for the deferred work, but do_rcu_barrier
> > > > > can help with that as well.  ;-)
> > > > > 
> > > > > Thoughts?
> > > > >
> > > > Makes sense. To be make sure that all objects are flushed. And as you
> > > > mentioned it is good to have it for benchmarking as a return to a baseline
> > > > point.
> > > > 
> > > > One issue is probably a "name" which would be common for both:
> > > > 
> > > > rcu_barrier()
> > > > kvfree_rcu_barrier()
> > > > 
> > > > i mean /sys/module/rcutree/parameters/do_rcu_barrier. From how i
> > > > would see it, it is supposed to trigger just rcu_barrier() API.
> > > 
> > > One approach would be to keep the old functionality, but create
> > > a new sysfs variable that does both.  Except that to avoid code
> > > duplication, we would likely end up with both actually doing
> > > both.
> > > 
> > > Another approach is to rename the sysfs variable.  This might
> > > work if there are not too many people using it.  Might.  ;-)
> > > 
> > > Other approaches?
> > > 
> > Maybe just rename from/to: do_rcu_barrier -> do_barrier? Probably this
> > would be the best, but as you noted, there might be users :)
> > 
> > To be safe, we can add kvfree_rcu_barrier() to the rcu_barrier_throttled() and  
> > document that it does both now!
> 
> That does sound safest to me.  We just might find that our users (if any)
> expected that it already did both.  ;-)
> 
Good. Then i will send out the patch!

--
Uladzislau Rezki
