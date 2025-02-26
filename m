Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076462904;
	Wed, 26 Feb 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585455; cv=none; b=oOmes0XBe4qPNwpBYKuYN9hcV60skzUGuReXcJ0u6B8dzPXPAjTE0sdbmZM0ePdtELAGq1N6TPFX0b25JT9WNfb1nCuIlago2PNSM6mBi8rRcbfGmoNB4CXq6ox4jnmxrE/p0lwilwyqT9jA1GT/f45T2MREsOQFf5GttS3D/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585455; c=relaxed/simple;
	bh=/tef5hK1LbNsH/Q3+DZN5woE2Jd5dXBPsgGGNeWn1OI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqt/cJY+/PFS3nhGR+SpTYqhWX/Q2pVuIzFDSjPI1s+X4YbNlcA8hBQBwrm5yUJ4Getkb49yXAkdfLZbl2TmVwcLK+WfNDIVkNQC/Ik9B6FZBGYawgFp6WCTjzunWhYMeIxQqAEr/GrszFZwojlP7Hrysye1DAN3GAsJy4a07Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4MktnKz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4MktnKz"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30930b0b420so61337281fa.2;
        Wed, 26 Feb 2025 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585452; x=1741190252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=;
        b=l4MktnKz73tZ45EZvSfV0yB/wtnxRAMurDDI90FCU5Eqmv5fsVsiMpJ1ZDI+mcpYa8
         tsBjvnW7M7J74VIWQOVzfZJ1lmLYxRBKxXc8oGr6D7WYVyurMBaN+/mBys70ZB/L2rwV
         Z37Zdx06tC93/ZPuG2tfe/kEpy3TS1yUbLLSREqiLarLOdniQlW0SzfeMiVBobSx5Ura
         4EAP4Wh209C4gj1PO4WnAT9Gc3gfq6kYGXFisvAUTyoG4nc7/TG9RprD1Z+dGXAYYOT0
         WqJCau1D21OyriG8tTQ1zxgl1SETjzbIQbmciFS4YkD2xIMqLd3wm8DnwOSia36qgcPh
         YeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585452; x=1741190252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkkyrTS/XUUgRrCusn5lCJsjmBp1WxMfD+vrhmxbdwM=;
        b=EHQd9jUsekDd6nEDTXxF9WzdwwiuEaHXAYj2pWIhEu1kAUvhXyHPptvsCjVTbhXYOI
         ZFK3GZdzZe45nDWJajGFVd8izi25L1qo2h8IJcAy4CzeXnTkutFIBjnMW1brOAopDZ3+
         +L+MUEb2T5rDPh+8c7gW3lIQSZnWfAwRDcp81KTR7c44O0ipMDEswMP5OjQgenEK6GMF
         L6igLSguTbsR8sEmdW97X9+RdK4e0FOVbkmooMuW9ss1Wl143vNrCdyKuMUbISL1iqm1
         BhXlSas7wtnbOGdZpLNlHTzCCPx9b8OO09aiHI/dPAcIpAXxtxA9YdZ5UVj1T753vyio
         HV2A==
X-Forwarded-Encrypted: i=1; AJvYcCUwAcYNC8WWAMM1BR6kxXWyj5gK5MX/aY2vrFjQ99KRb/vQqDS6VcI+vwCW7w9/qXBrvwyAfsaJ5DUSC6Q=@vger.kernel.org, AJvYcCXr6wQ6ldZAV3Q6CMo3vvPeQSoOqeQgrfryJh5P74sfKMNWoH6eVB/l79t/wbfNNtG5lQxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnSLJsUywgsqjCF8N5X89YEifHled8Hb95KVuOByLy2Umqcmq
	M8uzHnipWGme/srw4apPWocPeMw6rZkwWPRaRGk1f8EEvlqs3KQ8
X-Gm-Gg: ASbGncviUXNskeZYs3DRYiqQpOIL5PDcwdzoayNX6OpbuBPM2Q1+L/4pE5u7/6/D1ic
	do1NSwmU9BK2E+LWl7wf1iGtwLcmATMTcBp1bk3tE6JuSqq2edsinhz8D9kbOXvyYB2VHuEXgmq
	O6e5ROo9DobXC27k6sus07BVqFdane3NxMKOxMRmZR+ZAc/UQ9h+Kkf4LHOt7yqxZv4nS5+hWTm
	tetgYFuyOA1niXttVRbs9ipOmgmbDHqIpFEWeF6RMAifphXsbL8W+S9lBEUtilKcOFAYHqo8CAc
	D6OVC+/YdVBIWxIrGM1nqhftARBoPVzKGXWQYZ7VE0dnY4Wf
X-Google-Smtp-Source: AGHT+IH82gnLNVCGTkH+G8CSGIkUHUTCF4M+N3ekP+L3X9B7O3TZpIkugYLUjhbxuKtiakwaCquXQg==
X-Received: by 2002:a2e:9789:0:b0:308:e8d3:756d with SMTP id 38308e7fff4ca-30b7918bf8fmr31534101fa.19.1740585451801;
        Wed, 26 Feb 2025 07:57:31 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f4cffsm5537121fa.58.2025.02.26.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:57:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:57:27 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z7855_cJh493vHNy@pc636>
References: <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
 <Z78lpfLFvNxjoTNf@pc636>
 <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
 <Z782eoh-d48KXhTn@pc636>
 <8899bfa5-bd8b-4d34-a149-40f30d12cb1e@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8899bfa5-bd8b-4d34-a149-40f30d12cb1e@suse.cz>

On Wed, Feb 26, 2025 at 04:46:38PM +0100, Vlastimil Babka wrote:
> On 2/26/25 4:42 PM, Uladzislau Rezki wrote:
> > On Wed, Feb 26, 2025 at 03:36:39PM +0100, Vlastimil Babka wrote:
> >> On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
> >>> On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> >>>> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>>>>>
> >>>>> WQ_MEM_RECLAIM-patch fixes this for me:
> >>>>
> >>>> Sounds good, can you send a formal patch then?
> >>>>
> >>> Do you mean both? Test case and fix? I can :)
> >>
> >> Sure, but only the fix is for stable. Thanks!
> >>
> > It is taken by Gregg if there is a Fixes tag in the commit.
> > What do you mean: the fix is for stable? The current Linus
> > tree is not suffering from this?
> 
> I just meant the fix should be a Cc: stable, and the testcase not.
> mm/ has an exception from "anything with Fixes: can be taken to stable"
> 
Got it.

--
Uladzislau Rezki
