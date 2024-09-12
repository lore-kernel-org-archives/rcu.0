Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE23A1DB;
	Thu, 12 Sep 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157823; cv=none; b=TsrQmFebsPiFQG/V3kK/NbHHE37duypC2jJ9Jo0LJTBooGYI/oRs/lSXGkPNl2vzg9VK6I24vBXKzoy2T10zS5bPF9cIp4HokB/NS6KF0n4RXC+rTm+MJxB+lj2IrfOeOjuHL4RYnzSVUFeYasFBQo5oq2Bv23k60U4Duvnbjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157823; c=relaxed/simple;
	bh=KPL4usSEfGXF9z36Si2YIBFeBHEgXy9QBXsAgjvg144=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz3lskNqPI4nQhJ2YUer1i8fI6zO+mEgvtqNLL/vrR6uciBPpP8xShqCA4JRoLF5Vo7WSx9jjUMpy5oWz1jL4MhwT5WAWGcDeqQLvEpFi1Gr/hIpHs72cTvtBj4prZ/5Tjw93xzmF2ft2izhCS0FN23cx3xEQOxN++LNL+InYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CohGfKAQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CohGfKAQ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53659c8d688so865716e87.1;
        Thu, 12 Sep 2024 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726157820; x=1726762620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z9pxM0QZQaCqTjsL5zddkA5S0In18CVD5PAyOkUHsI=;
        b=CohGfKAQXf3FSqmyB6qg22ZqlLQNmVHbny8b0qkdXfvdd9WIceU+4SA0BsUx3hdk7j
         q3Sdc7L994bmsB8spTtQtJNoMz0LGRYzvz8U/08Oq36theImOGLVIuVKGZc/0KNGw2Qc
         3bdxrGDHEwevH3ZMZhwRSFgYKBdhn51IcDM24nYQGA4Dj2RGCS0VH8LtfnVfp7VrxYZE
         aB5Fum8RjorY5QBb+Ez9TR45/eS8gzUhlfpkgTW32HUcLVJnYyiS3ANlEiy2ORwfF3Ra
         aDSTniWpcY6VOOdf7XlE5gb6djXnUarYb01mV2wMw9SH/6i5ToihPffOZKMF32NJ78ub
         AAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157820; x=1726762620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z9pxM0QZQaCqTjsL5zddkA5S0In18CVD5PAyOkUHsI=;
        b=Esm+lTW5kDm3nQI+pF//+MsNdxgYg392YqK94Af3TolrJ4LESBuROFhhhK8jczsQIh
         m+vQyZKN3B9sqUcImALdqbgHzwO1akB7C2ulLgHz/yM1z1pv06DSRo80yB011QbcYUvI
         qBbhLlJY1HmkUKlfc3EOw/9os5hGXdBsXKAKadhBWEALugKDGnH8v/36WZ/ajPfbNQT4
         SS6b+hcRjQvd6qj9bDdNC4oLfW1Q5oWkg4JsQ/uprj61aCML1xWltI/HHWvAqsapn1Om
         2n6jwWHFk7/qnGpy+kikaBabbMrChZSqxHeNWeir1pXQ390+AzcLm5h+LvPEwr1mVO7/
         TI4g==
X-Forwarded-Encrypted: i=1; AJvYcCUSP/r1tcOE2rO0XgRUd+9zgbRy/QxSZZatHr/0/U79BGug4HJodGmyavE5P2vPP4th4QHlJjEDWZGgoIc=@vger.kernel.org, AJvYcCWTpnLiznFAw48QNcqEKxIp+hKb1VkU2cMxGXN/G/oR+fbe0oQkcu1l8DG24oKXt9MEx03n@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hAyOdbqKAOyS5Kwm6vo+Qh+Z9dZ2Q+FKzK5uXEQ+UmqVbzvQ
	FCFRVv6wOg4NP70WzZGJEg3K9rsI2UXJt3ItBKsMNYyV1D2zadzn
X-Google-Smtp-Source: AGHT+IEomOPKKKft4loCx4UNN5cjJQ2CmyG0CFHvRGhTZ1s58ae5HTOdGICveqT0uJyyrLVNgP7UhA==
X-Received: by 2002:a05:6512:3051:b0:52f:441:bdd6 with SMTP id 2adb3069b0e04-5366b7d4cdcmr3587600e87.0.1726157819969;
        Thu, 12 Sep 2024 09:16:59 -0700 (PDT)
Received: from pc636 (host-90-235-20-248.mobileonline.telia.com. [90.235.20.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d523sm1959552e87.272.2024.09.12.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:16:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Sep 2024 18:16:56 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZuMT-IpkBCGYzIIL@pc636>
References: <20240820155935.1167988-1-urezki@gmail.com>
 <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>
 <ZuFmWuUK8POsihzf@pc636>
 <cdab7aec-0f03-48ab-b162-28c4a2f198eb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdab7aec-0f03-48ab-b162-28c4a2f198eb@paulmck-laptop>

On Wed, Sep 11, 2024 at 03:39:19AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 11, 2024 at 11:43:54AM +0200, Uladzislau Rezki wrote:
> > On Tue, Sep 10, 2024 at 08:42:54AM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 20, 2024 at 05:59:35PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Add a kvfree_rcu_barrier() function. It waits until all
> > > > in-flight pointers are freed over RCU machinery. It does
> > > > not wait any GP completion and it is within its right to
> > > > return immediately if there are no outstanding pointers.
> > > > 
> > > > This function is useful when there is a need to guarantee
> > > > that a memory is fully freed before destroying memory caches.
> > > > For example, during unloading a kernel module.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > 
> > > As a follow-on patch, once kvfree_rcu_barrier() is accepted into
> > > mainline, should we add a call to kvfree_rcu_barrier() to the
> > > rcu_barrier_throttled() function in kernel/rcu/tree.c?
> > > 
> > > This would allow the do_rcu_barrier module parameter to be used to clear
> > > out kfree_rcu() as well as call_rcu() work.  This would be useful to
> > > people running userspace benchmarks that cause the kernel to do a lot
> > > of kfree_rcu() calls.  Always good to avoid messing up the results from
> > > the current run due to deferred work from the previous run.  Even better
> > > would be to actually account for the deferred work, but do_rcu_barrier
> > > can help with that as well.  ;-)
> > > 
> > > Thoughts?
> > >
> > Makes sense. To be make sure that all objects are flushed. And as you
> > mentioned it is good to have it for benchmarking as a return to a baseline
> > point.
> > 
> > One issue is probably a "name" which would be common for both:
> > 
> > rcu_barrier()
> > kvfree_rcu_barrier()
> > 
> > i mean /sys/module/rcutree/parameters/do_rcu_barrier. From how i
> > would see it, it is supposed to trigger just rcu_barrier() API.
> 
> One approach would be to keep the old functionality, but create
> a new sysfs variable that does both.  Except that to avoid code
> duplication, we would likely end up with both actually doing
> both.
> 
> Another approach is to rename the sysfs variable.  This might
> work if there are not too many people using it.  Might.  ;-)
> 
> Other approaches?
> 
Maybe just rename from/to: do_rcu_barrier -> do_barrier? Probably this
would be the best, but as you noted, there might be users :)

To be safe, we can add kvfree_rcu_barrier() to the rcu_barrier_throttled() and  
document that it does both now!

--
Uladzislau Rezki
