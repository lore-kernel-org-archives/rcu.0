Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639C1474B9;
	Mon, 11 Nov 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322433; cv=none; b=gNcByNnFeMBjxJpsw9RedAH9eW0ZlBUQTFpiWwmbvGJPldy5qSV4JdsiwPI24hs5aVA6ZlrN0SBDvu+TrQogo7q3HzCivS/L5bT+C/FlQntNkN1ufSE8P5rvj5wjjdxZ0M1B2GkOU0dlxMGrVApYMVEPkdip8N39A1AYF2FiDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322433; c=relaxed/simple;
	bh=843lH2nksBH9ZPKjXzoI7/eb/Yf7G60TjC9UvpvGhrA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6Rn7NTRHnq30XdEA52TZ7Gsu2BDxczdrh2IKQBSe8xPGmCdgS+Mb7Cs6mM38ylrpAllRVMW1tgHI1m2tV1oJIB9c6CHPKlH984QGuf7hi9CjP6R4MHuhlEbPQ/GPKtj5VbaxKXD0L32Q/G4SEMETHVAJ0+RHmeH6wSg5PZGZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2CXu645; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2CXu645"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4867567e87.3;
        Mon, 11 Nov 2024 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322429; x=1731927229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSf4fVS1djz2Q0u9Lv07J43WmD0mvpB6AA34eLsgv/8=;
        b=m2CXu645rVZ/EJ/tftZYmSp7gljychVfbqiFZGtAHP+URi2YIL2HLRkE9TPHE7LOj5
         oBcQest0WSBQLE9gsxGWRTq7noucdXWGlLNWdi7ULeZX2t6C8R6pYf/j+8pa5rOeoh7G
         QGs50BtV/3otIJNOxX5+ku0m1hSaVdfxiBQ5LosjE7PXesogpmbK4BvFQ0H3YbAmFo+h
         VBG0dIOLi7Dv2dkxjO2nZnbg6hdGksxrpQuoYueC3wpUEpZOV7hOgE4PSb8V9hPxhn5y
         AS7ugmmnJv9ViFu+7ykZcEqfTlbJiSJGd9U93vECoBPiDi9miPRGphbAAaH5DLCeGmAR
         WP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322429; x=1731927229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSf4fVS1djz2Q0u9Lv07J43WmD0mvpB6AA34eLsgv/8=;
        b=E4hNldESmSHvqN9AvGYlfszmIj/dat5BlQljaKjsiwRQrwSPuaZvCziareRcj3/0Qb
         X9TjZWW3IZitP5BEcYSOv7gp0mYL/S8UD6B+nrpzQEF7oWHhwN0+5UBVzPSq6PvgwBjn
         ughbQjc+ydv6Qz0AMKXGNer+SpeINHG1IO/BQrfELVZb++/kOYYkZdl6b0CLbxyn6P8k
         xSBW7sHkWD27LFEIN5vze3UpHnSxWjeDetoUnDTUnqELVEKZG7edr2qG+qqc86H/TYwV
         1pL24Ea9YRRDt/TDKYQOHnYLDkWmMnJOwSRhfuNP/MPhzI3rTkOk+htidodSYuewM0kj
         HGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnCgAc7juT5nftF1dYN/UqaPz0BtTiOrWgPIK60hsCunnvUBpRjYPP0UUYNjh/4DhzBcsU@vger.kernel.org, AJvYcCWioz0+fWzg03Npu/h48o5xck9IgYLgy1iXhYVaHFcnkRQac6xbWybF313XnFQ6DECeVQk6KrMC2YDa/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHf0mYKb2H0fDlOzumClxrCPM9FUfMRMOuklPX4q9dnRF7eWga
	AZuko6+mQg7fT3Mkr4k3SwdjlFhdZyS2UkD+JdW0Z7qVUEpL0Ev5
X-Google-Smtp-Source: AGHT+IGcUvXmPPxitucFWfX6c3npi5xquT33/uRqlCJQp7f1VQ5K2u9judneEGjIFJ5JuMKAJhxxQQ==
X-Received: by 2002:a05:6512:308a:b0:539:fde9:4bbe with SMTP id 2adb3069b0e04-53d862bd55dmr4704725e87.20.1731322429101;
        Mon, 11 Nov 2024 02:53:49 -0800 (PST)
Received: from pc636 (host-95-203-27-13.mobileonline.telia.com. [95.203.27.13])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82685f7csm1515516e87.93.2024.11.11.02.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:53:48 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Nov 2024 11:53:45 +0100
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <ZzHiOQCIwt_hyFUQ@pc636>
References: <20241106160223.42119-1-frederic@kernel.org>
 <20241106160223.42119-6-frederic@kernel.org>
 <f4c8fcaf-185c-47f8-b926-5bc2429103a4@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c8fcaf-185c-47f8-b926-5bc2429103a4@amd.com>

On Mon, Nov 11, 2024 at 03:24:38PM +0530, Neeraj Upadhyay wrote:
> 
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 6d37596deb1f..de7d511e6be4 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -890,13 +890,13 @@ kfree_scale_init(void)
> >  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
> >  			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
> >  			WARN_ON_ONCE(1);
> > -			return -1;
> > +			goto unwind;
> 
> Do we need to set firsterr = -1 here before "goto unwind"? Otherwise, 0
> is returned from kfree_scale_init().
> 
> >  		}
> >  
> >  		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
> >  			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
> >  			WARN_ON_ONCE(1);
> > -			return -1;
> > +			goto unwind;
> 
> Ditto
> 
Let me check it!

--
Uladzislau Rezki
