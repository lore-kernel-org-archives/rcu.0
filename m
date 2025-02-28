Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52F26A0DB;
	Fri, 28 Feb 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760034; cv=none; b=IdVVkpz7Wzs37IGu9pLzRVLqYtheNwKypZe6i7yuNAFIiajbCMVMJRtJe/rI+s8Oz8U+k50jZMj8ocghGOXhwYwaXkmBm3ncKalM2yGJgo6/GD8+wzj75MsvxiIW+/m1By4exfrpxnXdRJmufDtDyJAgqsKXIoMFbeMPGawMbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760034; c=relaxed/simple;
	bh=uiUa/ZFYDk22UMF6myD1RN/fiJgmsHZGTHpp4pOj3CU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EokVCAbqTCC8TnFWyzojqg9a4MC8s6K86pIWFxtMV/y7lNSL1YT1JQekMS5ZquMDFeYQcBD9qCGUPbAhStwsv+dKmfVipOl7A60m1Sy0YMfHizFMFXSXZ8FbD5ACVmPIq0DR46SMhIh/HirROn50Jus+C+iDnz4/f19mUvR9pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjXR/VME; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjXR/VME"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543d8badc30so2590865e87.0;
        Fri, 28 Feb 2025 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760030; x=1741364830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruZc5rE74kB9l6IBoGmzRC99kLEtf45pFZfGUKT4nRo=;
        b=NjXR/VMEDLI4g5uVSjA/od+kA2PtdvMKsZPPkdSlKMXa1kykSy2TLh5+STPwukKxRA
         QtUkbhZMZXVjbS8JsuiJyg1mDibsr7gK1zLwQsjEMjXNPBNjkUEDmVXff/PH23ABiZ1v
         asn791Dd39RA9yov09RwsB3+uj9py97bRenIfBDGMSs5UUKvUlG+12JDPym6Hy72EQ5O
         Zj0g9xXn51w8wS7ZWA+47KuaYzGv1e+7Grda+vDqR0nst6Hin1lv1RQs8CNWEQr9uNad
         FnBd1O4Fost1PkbBMyuDC49Q5NeduaKbmUd2jMAYXd7ij+SMngvmKvbobXXaxhhrAOXt
         9DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760030; x=1741364830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruZc5rE74kB9l6IBoGmzRC99kLEtf45pFZfGUKT4nRo=;
        b=C7M5X4h+gI5996YEZUU14KGBy2FiGXOEpHrHV0AvQZ3u+70UVnDlrYdPBfVGIRjxVG
         LonkNOCy6Gijrl6l591OTUexk3hVQfOP14wt9mdepSMtXdmKa4wstdm0fs4hTYMh5qhJ
         cP8t+LmpALtAQLDRYhXEnftsu0b5i2E+ScvWjeicKVR+VBduIUuXsZhBsZl5Y8Z7xMN/
         4S7x8+p3/drAbS7gWEFiGaYh2eQR8ADsCgOzCX80/Cfb22ewJP+dfQJ4uDf2KAEdBeJ2
         Xb0YHYgqMwkf4LLzGRxToMJZ0DTueUfa3l9nYaZ6bhPsWPTJFl9wztde9zx/Yu56H/iv
         pRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDLPitCBdgcVukyVcEeWsac9HRPU6LRnGM056aOiUWQkp1zqtb7gl0wlle/qVpTP6jPWnW@vger.kernel.org, AJvYcCXB26Jevvc7+taRE9+QePkEHgMP8s8seoHUz3ERbAAdFqs1qhCbEKzvcUvNwE0Asm+G+oO8TzOO8KtdaLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YOo9h0VTRcgLmaeGCMnbUkZ4yAF4jj4NwW6I2laOGK15MNgu
	k2Io2ofbc+HIbLHBtM93c4AlNwZnvNNNZyjWyQTioY+5c/GTMSwc
X-Gm-Gg: ASbGncuinycSxtmyF+re0AvUirP/rAJhTipNKofHtL6ZHD3Z20vHqqo5yxwsT7S8+jC
	9lRsm57QWGpVQ9TAN9BwXLxwJh62KEWTu1uPs4orO4ba/1nqY/4t16KH62+/TVhvb+522YPQE24
	8HNM2Q6lQ0JsjkXBSvGKBBALKjTg1rfOdQU/bAHanyBfsi+VbNo08pGgUxUsXygGT3/54nkkPhL
	ZWbn3z+FXwq28lYC/9J/x7USsZdeR/3hotGKt9lPj32eXN8X2utV9ltaXRV98u/GZteyEKasNCj
	QOtaTjnogH1CfxiyxCsJ5IfIvXexPir0AaSKnxZCSbbMnfiA
X-Google-Smtp-Source: AGHT+IFBcQjlrOGAdU5olVcCKRvcQf5ITnKLMelFk+NStupCDNbjKh+wL+NxSNVcP6R75XQIKLGp5Q==
X-Received: by 2002:a05:6512:1293:b0:545:a2f:22ba with SMTP id 2adb3069b0e04-5494c331e56mr1969061e87.37.1740760030078;
        Fri, 28 Feb 2025 08:27:10 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417a683sm539165e87.76.2025.02.28.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:27:09 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 17:27:06 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1 1/2] kunit, slub: Add test_kfree_rcu_wq_destroy use
 case
Message-ID: <Z8Hj2sGL8Cgc2TuX@pc636>
References: <20250228121356.336871-1-urezki@gmail.com>
 <b97fdb00-6367-4eec-87cd-47f6765fd2cc@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97fdb00-6367-4eec-87cd-47f6765fd2cc@suse.cz>

On Fri, Feb 28, 2025 at 04:49:24PM +0100, Vlastimil Babka wrote:
> On 2/28/25 13:13, Uladzislau Rezki (Sony) wrote:
> > Add a test_kfree_rcu_wq_destroy test to verify a kmem_cache_destroy()
> > from a workqueue context. The problem is that, before destroying any
> > cache the kvfree_rcu_barrier() is invoked to guarantee that in-flight
> > freed objects are flushed.
> > 
> > The _barrier() function queues and flushes its own internal workers
> > which might conflict with a workqueue type a kmem-cache gets destroyed
> > from.
> > 
> > One example is when a WQ_MEM_RECLAIM workqueue is flushing !WQ_MEM_RECLAIM
> > events which leads to a kernel splat. See the check_flush_dependency() in
> > the workqueue.c file.
> > 
> > If this test does not emits any kernel warning, it is passed.
> 
> Well the workqueue warning doesn't seem to make the test fail. But someone
> will notice the warning, so that should be enough. We can't instrument
> warnings in other subsystem's code for slub kunit context anyway. It would
> have to be a generic kunit's hook for all warns.
> 
I agree.

> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Pushed to slab/for-next, thanks.
>
Thanks!

--
Uladzislau Rezki
