Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D214813;
	Wed, 22 Jan 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567767; cv=none; b=JBXGW/gDfTaixyxgyUpe49jCaSK/gJmA9wlVTuzoukDN4xGnLXIIbpE1wJJvKpgUezREBvU1j9SpN9uC7oNXBXDkVgG8mGSM/RBvO7VlO5VROko5WH4fRCZK55KU8NEyVZ6bX8eUIoX/fKneAI9cQcFwN7453lOSy09DrP6Igl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567767; c=relaxed/simple;
	bh=c2OwEFKW7EtbBNFo0i8JNWkZh9rxOR1I4NknK4lEXGA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIYVK3MyOy+1wS77rLpVMnOZfuRLw3xD+0qZnWtG/un8NzqJkFU0G7k3l6Ebd0LazU8glCCI+j8W2sslmrfFLE15JjSRoizPCTe4lxhSlhBHGK8ZLvSZ+tHPWQcE7Va5ifI++sWmKmc5wpyXSw3FjacehkaW6ZbZVvxDzH/wUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSy4owGC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSy4owGC"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54024aa9febso46354e87.1;
        Wed, 22 Jan 2025 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737567763; x=1738172563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IICD8UPGAZCB4EBlaldQl7oBqIWOMw3Z7H3Rk+fUvSI=;
        b=aSy4owGC03Pn5jXbYQp8v01DqdEhKCyPkFYEMbNMuLjG24FxkkgnGUTIQ8zxPv4Lg3
         +SLCXb68JbJCUb9a7x0m2+rq0m6rGRd3FedyDlxP8C7QgLeSykODOja1mLbaiqmZaJCH
         QkZArYLZM7Gn8pyD9c5jvbI2E3b4aEmdtk1dIO7JpXhWf8V17mq8FsS9BeGRpEqPLSBl
         s199ZAWf/kY2hYDJ35nK7o5IDtud/mw1Ne2V+PMYMuQFpZXOoyzP+Gt3Gp98U63SLEXz
         nrUgLuK7i5XvYujZmfl87Uf1Q8kJVLkHQDxADA2YHz0TLmCyWglEn1KbzkxfxUC0wB3X
         bb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567763; x=1738172563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IICD8UPGAZCB4EBlaldQl7oBqIWOMw3Z7H3Rk+fUvSI=;
        b=Pd6av+Zkb801Q+X4zYlY+3kNoUwp6qkWEXX1Uu/xVqAlmHD/9lfxPn6QB0WSsiffrL
         8y8w+djmmNIbAiUdrbS5QSnmvKurmd93i6oUrXWdPJIM/38xVGH6L/bb3ZjkjKSe+NqC
         9afw5tDhb4On4pXImyDP5cm3T1kkJULSfzQHlenxPkU7Gpd24ANQiAEas/DZQKA0uxOV
         ZGCI29jKNRA8NCD/Jd+Y/X43uhty5I9JX4gZkaY05xAWDhL+qdPGG5yNf9aHUPp5hK+j
         HP4egTUYuRVmBqoUgoDCauJyDsZb6k/fjWiqlI3JmjeY+am+gd49CvsnReNbXraf2Y+h
         dB5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdm041tDcs5FkIHWDFxApVfoFn3I33aQGfw9/0VXDHu9b7tibVV2yDqcj6lQi12jszhVaA@vger.kernel.org, AJvYcCX0XQV/12sIDm128gZhDuBDmEU+RLLi/bA+mwKCnXN++krRL33ZL6Qycf5jugaKJS3kfZON4e0NcbCusCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf2xqxzR7kRUZ0zK0V4c4pMLPOFYibXLPP+XEXV8seEpwBf0c
	y2Mj3THobXRbjFN2KYD/+uDsl99s4pKXLxPwcpa9PVbOfqV7WU8U
X-Gm-Gg: ASbGncvJVWJhhgVTpkxoFmO2LIX9E5TQ3ZaWtPYCNtbJcRYiWpBQ6pWbCD2r5zOROe9
	BrUOzIaLKtVIrWsJecoMqXHaG1xnLZ4v7mrfge4jINShDpplppV9ZVUusXbpwEFRu1XtNi1ODjI
	lIN5TtewzgorzZIHjm0Lns9WQxGFTEV5dDg5+gLgzLiLo9LKTGPyGjT9+FqZ+QgEClk7EuOcr+K
	flG4dwH2QFRkFVgcYQWMKpB83b7fyLZCmO3wWBTBmTTTSNKmQoS+LejX2U7K8H3ljDUoNT3VTCn
	ioRpJRdldwddnxviuyFRo6vA
X-Google-Smtp-Source: AGHT+IHvlxE7aTg+tur1LdnZRCSfrXzoKKsrI8QIgY9dKAWz+5woObHEVJ+wQOO5cMBd1SfQN89BUQ==
X-Received: by 2002:a05:6512:2213:b0:540:5253:9669 with SMTP id 2adb3069b0e04-5439c282c1fmr8422812e87.32.1737567763352;
        Wed, 22 Jan 2025 09:42:43 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af07ae4sm2308906e87.47.2025.01.22.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:42:42 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 22 Jan 2025 18:42:40 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z5EuEFZbBgaCPDYo@pc636>
References: <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>
 <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz>
 <Z4-ruJ3KVD3PieZi@pc636>
 <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop>
 <CAEXW_YQQii5061aNCvdCtvoBZra+5PxFWJcDCO0JWjSM3PURTQ@mail.gmail.com>
 <c210c44d-d1b1-4dc3-839d-f99ad73c3ee9@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c210c44d-d1b1-4dc3-839d-f99ad73c3ee9@suse.cz>

On Wed, Jan 22, 2025 at 05:43:06PM +0100, Vlastimil Babka wrote:
> On 1/22/25 16:04, Joel Fernandes wrote:
> > On Tue, Jan 21, 2025 at 3:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>
> >> On Tue, Jan 21, 2025 at 03:14:16PM +0100, Uladzislau Rezki wrote:
> >> > On Tue, Jan 21, 2025 at 02:49:13PM +0100, Vlastimil Babka wrote:
> >> > > Right so that's the first Possible solution, but without the #ifdef. So
> >> > > there's an overhead of checking __is_kvfree_rcu_offset() even if the
> >> > > batching is done in slab and this function is never called with an offset.
> >> > >
> >> > Or fulfilling a missing functionality? TREE is broken in that sense
> >> > whereas a TINY handles it without any issues.
> >> >
> >> > It can be called for SLUB_TINY option, just call_rcu() instead of
> >> > batching layer. And yes, kvfree_rcu_barrier() switches to rcu_barrier().
> >>
> >> Would this make sense?
> >>
> >>                 if (IS_ENABLED(CONFIG_TINY_RCU) && __is_kvfree_rcu_offset((unsigned long) f)) {
> >>
> >> Just to be repetitive, other alternatives include:
> >>
> >> 1.      Take advantage of SLOB being no longer with us.
> >>
> >> 2.      Get rid of Tiny RCU's special casing of kfree_rcu(), and then
> >>         eliminate the above "if" statement in favor of its "else" clause.
> >>
> >> 3.      Make Tiny RCU implement a trivial version of kfree_rcu() that
> >>         passes a list through RCU.
> >>
> >> I don't have strong feelings, and am happy to defer to your guys'
> >> decision.
> > 
> > If I may chime in with an opinion, I think the cleanest approach would
> > be to not special-case the func pointer and instead provide a callback
> > from the SLAB layer which does the kfree. Then get rid of
> 
> Right.
> 
> > __is_kvfree_rcu_offset() and its usage from Tiny. Granted, there is
> > the overhead of function calling, but I highly doubt that it is going
> > to be a bottleneck, considering that the __is_kvfree_rcu_offset() path
> > is a kfree slow-path.  I feel in the long run, this will also be more
> > maintainable.
> > 
> > Or is there a reason other than the theoretical function call overhead
> > why this may not work?
> 
> My concern was about the overhead of calculating the pointer to the object
> starting address, but it's just some arithmetics, so it should be
> negligible. So I'm prototyping this approach now. Thanks all.
> 
You are welcome :)

--
Uladzislau Rezki
