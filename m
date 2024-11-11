Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE161885B0;
	Mon, 11 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324146; cv=none; b=ZBHAKz0X3j6cnbsFjAHjeT3JeisueeZY/Mq50Q8t0XGGt5vFMX4SpIVnJiOp+b3bfTtYblAQ5OWQlI1fs3U4JTJsXptJ/g9N73gxSlq/X7FbVz+78UC7rFuuKRXOEWPorxee/FDvduvnBOZmTWBxLA4afteILeX5+0/0SZfZE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324146; c=relaxed/simple;
	bh=fT9EpSzRghU0UxH9Qr/K9BvfBCbPQKU/BiE2iPSyte8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INVBgjUCWHJsr/7pNiSQc5jays/YQmmK/qCWFFXVIct2ZF8mXINo+C+UqLwM/J8d3/4APxj2BVvuKoxFxHxVL0J/dYkeYOWyOt1842i65chsaTAb+1fL+1AqajIHKeq26K1SeCEyclfaJm+c3GACoTtkgJUX6FJUZx+uq+6MBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai0VXwsm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai0VXwsm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f53973fdso4224196e87.1;
        Mon, 11 Nov 2024 03:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731324143; x=1731928943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2ShAV+iUab0F036raXpvneYavv8KxTamxvmGMa7Tms=;
        b=ai0VXwsmt8UnqR0ATbZ1CMrOXFDli6UPcriS2m56EYoKzvrAf8Q8RTTqkiDk6DVJ0R
         /r8TjLWVNafTn4+kEf2J4NfyNk2+9KjMnk7IvtJXF4EoRjPpLxiG7sBSR0azOBpFpvZS
         lUyafRXX8DEKnYfUGdzt8dgVdVyAnM376kKKmmpIzaWNFvygqMlqmTi1k6zzPqEJdlM5
         Yy4es1Iw40xb2mAgliRxf0u4O1yVMtWkLESzxxNVr0wp9NjcU1NMAkkeLiU9VKTgVBFv
         xkxrW+ouwM/UQT8EKIrzKGllMWSJWlmND4uL9Cq8OU60WpHrzX5BB0jNmrkD7f2N9IOE
         5TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731324143; x=1731928943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2ShAV+iUab0F036raXpvneYavv8KxTamxvmGMa7Tms=;
        b=q6dAfXAcgOknMz+Wq6OASZmV1AUI9ouYwgpKQnomCSLQT/K+E7nbHMpx+eeAfB+WA3
         1k65eT+UuP3N/7CSG+O+ZQ4J8n6jY8J/YA6aixDIeahZTJmmQNgwqLXdvvWdHe0j/6Im
         3LkHCGzruYiIRllp+EpezfWUjLszBOgitTVnO3Fn7Ofv6hoNfTmStVUFazXKaHuDulyA
         qmkBW0k10+kEnlKg3Wz0DC2tr+QULIR++BGcUN/5cIxcbPomIoAb1//ZeNMiMxSLN4av
         Mh1WGpQF90rlIm6wTuKqC8ithqLMjYzCEJTLMRYfabhtajW4nO9RgnzfWp3imVYV0jfN
         8fXg==
X-Forwarded-Encrypted: i=1; AJvYcCUwQk7PhokNzS8BdXOfnEcYH7Ut3gB8xlAmqikM1RaNiyW+fPLKxW9hn5P/HWz2RFsmoV9H6bX14avzBIM=@vger.kernel.org, AJvYcCWEjR8wHTbwr3OGieoHxWId4H4ApFABLeHjkOzcXRb+VND5kNlcY0bbtO3uO1cAugXMhvAV@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmD/HFJE7VtbI0b5WA6Rxw6ZwZC2mFQbCDclTXLSjo6DSXm4y
	KsVyCOfYm2tflexkpWZ9ypEmPYQhSbkToIRKzO05O+jx6YyZWhP/
X-Google-Smtp-Source: AGHT+IEiECsgdX3W0LPfJMzgjKot2hB/hRcmlcUeVobslnx+W7WADsUAz18UF9zS24mwpsg2QTDu4Q==
X-Received: by 2002:ac2:4c43:0:b0:53b:488c:fd37 with SMTP id 2adb3069b0e04-53d866d0cfbmr3816172e87.12.1731324142662;
        Mon, 11 Nov 2024 03:22:22 -0800 (PST)
Received: from pc636 (host-95-203-27-13.mobileonline.telia.com. [95.203.27.13])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826af3e9sm1514946e87.267.2024.11.11.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:22:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Nov 2024 12:22:20 +0100
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 5/6] rcuscale: Do a proper cleanup if kfree_scale_init()
 fails
Message-ID: <ZzHo7PuhABcgGcg-@pc636>
References: <20241106160223.42119-1-frederic@kernel.org>
 <20241106160223.42119-6-frederic@kernel.org>
 <f4c8fcaf-185c-47f8-b926-5bc2429103a4@amd.com>
 <ZzHiOQCIwt_hyFUQ@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzHiOQCIwt_hyFUQ@pc636>

On Mon, Nov 11, 2024 at 11:53:45AM +0100, Uladzislau Rezki wrote:
> On Mon, Nov 11, 2024 at 03:24:38PM +0530, Neeraj Upadhyay wrote:
> > 
> > > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > > index 6d37596deb1f..de7d511e6be4 100644
> > > --- a/kernel/rcu/rcuscale.c
> > > +++ b/kernel/rcu/rcuscale.c
> > > @@ -890,13 +890,13 @@ kfree_scale_init(void)
> > >  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
> > >  			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
> > >  			WARN_ON_ONCE(1);
> > > -			return -1;
> > > +			goto unwind;
> > 
> > Do we need to set firsterr = -1 here before "goto unwind"? Otherwise, 0
> > is returned from kfree_scale_init().
> > 
> > >  		}
> > >  
> > >  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
> > >  			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
> > >  			WARN_ON_ONCE(1);
> > > -			return -1;
> > > +			goto unwind;
> > 
> > Ditto
> > 
> Let me check it!
> 
Right you are. I will repost the patch to be align with a previous behaviour.

Thanks!

--
Uladzislau Rezki
