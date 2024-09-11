Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754114F105;
	Wed, 11 Sep 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047842; cv=none; b=eyFCXqi+yMwTMVHUtZJTE5QihrULJlNI+io2DbC+R+agD+iu57hZru4HE6oXsNox0EVaZYcPPW2Fcktb8xr4gRWZKoVGubBY8lFuYp3chvnMEgbjcB/vRG9WGJNjn6sM3ycL6IJtN2FI/VselYalqJDjiFeqtMyogQvBL+qhNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047842; c=relaxed/simple;
	bh=Upu3RSMMQXqVbQkLU8A4pW+vF+nso3kCAcQkkCqDWa8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFLCmgCdbMLoGHrermbJfqermPrSdQI1HjN/3xfi7xJBUeVGba9EXPiTAnf+2VM1NWH6I9HhofMeYV9KoLzg0Osdi2xcYOWHQbZBvhCYMekpiHDdj/MihgIpy8c36SVFmaDMdBpZqCDx7GtZ2KRBzQbtxpJ6i7aZ8SQmT7aWV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBVCN2aB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBVCN2aB"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so8012924e87.3;
        Wed, 11 Sep 2024 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047837; x=1726652637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vK4hXm3cLDT7VU3thxO/xWMzCFk73a3C3JCmK+dAb1c=;
        b=NBVCN2aBo28aSOgQapOYOMBZQhP1+Zgnvh3tMKAd7ghGbwRde6niPmrTeDyMBceQHp
         GYG3CSzaOQwr+XPViuVyXa65NXUWQwJgsn8MwyJk5dJJs1UbZEDnPeTLh+5hyydQ70Ay
         chZJE9C5GkM3xNXCpC3FMoeLw5pca0nGBcwXV02BdSeoB1wYcfH7jP7jUbZ374EAHOEd
         7Yucwa8Vq4t5HvwXEPPkm7zsANxG5RF22YXKsLMPEGBovOSN20OddYvg/2Vvhjc+FfPu
         /ycmcNf/BxXmgDAfXaEL9g7ItXb+UxPt+0eR+3xkbBWtG9yLjpLydZS2/YNCNPO5rpZr
         Lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047837; x=1726652637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK4hXm3cLDT7VU3thxO/xWMzCFk73a3C3JCmK+dAb1c=;
        b=ADiGNfTMWTWbN1SWwg/AuXY3suclcXn3OwFbNIg7X76ZH2xafXOx2IRq4WpNPqbVVC
         S7FILaBqEwpXsW+wiYIygjcz4h68B+nW730ApJgmC3OBojY5MsqrrpqmYJDL+IiJtGc2
         TVMv6ESeKkfFx9SRlmMEYGbBlppSTUkQdn2KN0lXI2otLBNBflD3D7HCgIWtjsnUyTAZ
         ljkjERoWGWhe+cuMKkd2ocY74WpQZsU3LQIePtkXPL3Pvn9cDiPrhXx9L9zvIFB7BmxQ
         fyQQ6lBxL0EWpnc7nJ0uufFI/nogMQaMHvw4lx/SEnhbi+RaiNWPIFL24Ru/CP0AJGsc
         mRVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5f4xIXVSWnQjkqBR5vLUPRyEoow7OxoQiWNQi5C3ExCD1nV2ivZIKLd5dY4T2Tk/H9Ktf@vger.kernel.org, AJvYcCXFYsaEOW1sZR084UMcwVpfLUG2lvJ6dmh4YtZER+GzyDInDfzrk0PEvWaa2JDkkrF+UBg5uZ+Hm8cIVZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoED8QksE8UuuopgNryfvtKUSUVPC7F8lpovn4Ob8ujijykUq
	sy6I1tTBMlCJ0bGkCK7fKjD/drDEx2EAUPiLo1dd1a4wepFTolFtgRbMMw==
X-Google-Smtp-Source: AGHT+IHbQwlRNKAug8LWOfz3XOOyd8OsiWy7fGS3gti0cKlOImM2McqhQVBhgn/SJBfyvhTr8TQh6A==
X-Received: by 2002:a05:6512:4024:b0:536:553f:3ef6 with SMTP id 2adb3069b0e04-536587b034dmr11385493e87.18.1726047837179;
        Wed, 11 Sep 2024 02:43:57 -0700 (PDT)
Received: from pc636 (host-90-235-20-248.mobileonline.telia.com. [90.235.20.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f868e60sm1510053e87.38.2024.09.11.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:43:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 11 Sep 2024 11:43:54 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZuFmWuUK8POsihzf@pc636>
References: <20240820155935.1167988-1-urezki@gmail.com>
 <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>

On Tue, Sep 10, 2024 at 08:42:54AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 20, 2024 at 05:59:35PM +0200, Uladzislau Rezki (Sony) wrote:
> > Add a kvfree_rcu_barrier() function. It waits until all
> > in-flight pointers are freed over RCU machinery. It does
> > not wait any GP completion and it is within its right to
> > return immediately if there are no outstanding pointers.
> > 
> > This function is useful when there is a need to guarantee
> > that a memory is fully freed before destroying memory caches.
> > For example, during unloading a kernel module.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> As a follow-on patch, once kvfree_rcu_barrier() is accepted into
> mainline, should we add a call to kvfree_rcu_barrier() to the
> rcu_barrier_throttled() function in kernel/rcu/tree.c?
> 
> This would allow the do_rcu_barrier module parameter to be used to clear
> out kfree_rcu() as well as call_rcu() work.  This would be useful to
> people running userspace benchmarks that cause the kernel to do a lot
> of kfree_rcu() calls.  Always good to avoid messing up the results from
> the current run due to deferred work from the previous run.  Even better
> would be to actually account for the deferred work, but do_rcu_barrier
> can help with that as well.  ;-)
> 
> Thoughts?
>
Makes sense. To be make sure that all objects are flushed. And as you
mentioned it is good to have it for benchmarking as a return to a baseline
point.

One issue is probably a "name" which would be common for both:

rcu_barrier()
kvfree_rcu_barrier()

i mean /sys/module/rcutree/parameters/do_rcu_barrier. From how i
would see it, it is supposed to trigger just rcu_barrier() API.

--
Uladzislau Rezki
