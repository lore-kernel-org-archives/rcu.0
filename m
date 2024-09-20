Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2214E2E1;
	Fri, 20 Sep 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839343; cv=none; b=MMMbvoVA3oow8KmRNuV9rQAvLiDRsCOISDTBdQis5B6bc7xf/OJrp2H010AYTsjfbwRkMiXiySDuk3cbOnpwl+KaUvXOcGxSKgGHh0u4Jen/7y07rTWoj0K31/uBbRYaCYFdoNMpq+abYYRtIMBhJ7Z4l3yKCEIPJDUpbgX7KMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839343; c=relaxed/simple;
	bh=DyLTOgl1eE49gc6jW4IfMEpbgKe0+TpW/tB1aSZr50I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVyhAU8AzFPNYhcvlo9Xsm/d2i9i+OmLkkANbgBieDTGXOSjif2S7rCRXDiXZNCU07CXrlsqR1MadE0g1QC6FyOfHBvAzLYqMFbiwSbZnUylZJ2mQ3cWJ7leU5lFwWBNwL8kurQxKFDBsH9RmNsX7YgsAnT3qcvg4etSMa5q+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoGTwCm3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoGTwCm3"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so1436587a12.3;
        Fri, 20 Sep 2024 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726839341; x=1727444141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WiT20VvGZEoLul+yBbb3XAfILOiLHoijWP26iP09Gk=;
        b=aoGTwCm36yslffPuYVIvQqpzd4LUP0U/JL14et6reRPuiCg1u+wshf/ej7R417dM3C
         BpWGqoJwsCyFnpleVEZEqzVP3csW+HHkyEBXCu2CrPfxXQozzyvkjSTjNsqgbCpeay6Q
         +kvH5Lr79RX/TSHcF6LUVK+vnMhrAxGzsrLfxFRCZPGtSD5hpqyCiB6bbWAi1LIvG4iE
         U3Uy1rFtadFs2brZjVdp4FyPg0iFjviICaLihRLvMm+t6wd/H8UX0K/3/dgMvCOYo888
         UxTbFAXInOJ2Qxuqev9LonXgCyvsac4CWztIAgSsQdcQFZX/Omo4isHI1bYP5mF4BKvU
         Ut6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726839341; x=1727444141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WiT20VvGZEoLul+yBbb3XAfILOiLHoijWP26iP09Gk=;
        b=mjvAfoLscOOY4D5yaO+WNZHD4LrEBfhj9n3C57yqHkE51NYRftLd/q7M1aVxb82ziz
         5SanYGlbzVO9auYOJqaXJpEPJOk9jbWA3EbLmcbrCRQaFWFCNVt9ZaL0zhfPxglTjHAb
         oUn5+tLC9ml70oTvg4f7DsYfNaDCC7SNqmyrZEcOVFTmbK9bEW0QGFuGg32HQhKoe6E/
         Mwsf/aGDxRBbV4ruTJXMQG6jUoSDETOdeBQYR9GmswGiY1evqXpr336HDvHOjnQ/lEzv
         BF6Ef5mMkWMOPAf/UorGwsSJ6DUdObi86IdBQnAZFzv3yu9kwSPXbmj3unJYPyDNafHN
         9LIw==
X-Forwarded-Encrypted: i=1; AJvYcCW6SNcUxxV/mvrqCxtUPGVB3LXasA6/y+Rc5kw3Z6bhdhtKbEMeaeLjr4sD48Mnw73BDCY+@vger.kernel.org, AJvYcCX9tvJHOjEUt/zYPu0D4ZxVdlQT/HKNuQKseR3fUFTexXH7vV3A7qP9UYH5ZQjnId/z1rY0mIMwi46daUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRKapfwRvKXR9jEPQLDbObpAd+OTryndNCig0zyd2IOu+kbGr
	XXWZ0yf6zPVsyzyAiOku3tsNnKIPXFAYI6B75uKn/Qi/lu9vSPkK
X-Google-Smtp-Source: AGHT+IF9E6a541Mbjo9j50qxF9waC4QlIEoOI8U2Cwj3s1tGGsRGG27E/xRuctO2OBAGuNi0Wwiajg==
X-Received: by 2002:a05:6a21:9216:b0:1cf:506a:cdcc with SMTP id adf61e73a8af0-1d30cb65dedmr4244909637.43.1726839340992;
        Fri, 20 Sep 2024 06:35:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460110fsm95281375ad.96.2024.09.20.06.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:35:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 20 Sep 2024 06:35:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and
 test_leak_destroy()
Message-ID: <6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>

Hi,

On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
> Add a test that will create cache, allocate one object, kfree_rcu() it
> and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
> in kmem_cache_destroy() works correctly, there should be no warnings in
> dmesg and the test should pass.
> 
> Additionally add a test_leak_destroy() test that leaks an object on
> purpose and verifies that kmem_cache_destroy() catches it.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

This test case, when run, triggers a warning traceback.

kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy+0x70/0x11c
WARNING: CPU: 0 PID: 715 at mm/slab_common.c:511 kmem_cache_destroy+0x1dc/0x1e4

That is, however, not the worst of it. It also causes boot stalls on
several platforms and architectures (various arm platforms, arm64,
loongarch, various ppc, and various x86_64). Reverting it fixes the
problem. Bisect results are attached for reference.

Guenter

---
# bad: [baeb9a7d8b60b021d907127509c44507539c15e5] Merge tag 'sched-rt-2024-09-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [2f27fce67173bbb05d5a0ee03dae5c021202c912] Merge tag 'sound-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect start 'HEAD' '2f27fce67173'
# good: [ae2c6d8b3b88c176dff92028941a4023f1b4cb91] Merge tag 'drm-xe-next-fixes-2024-09-12' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
git bisect good ae2c6d8b3b88c176dff92028941a4023f1b4cb91
# bad: [c8d8a35d094626808cd07ed0758e14c7e4cf61ac] Merge tag 'livepatching-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect bad c8d8a35d094626808cd07ed0758e14c7e4cf61ac
# bad: [cc52dc2fe39ff5dee9916ac2d9381ec3cbf650c0] Merge tag 'pwm/for-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux
git bisect bad cc52dc2fe39ff5dee9916ac2d9381ec3cbf650c0
# bad: [bdf56c7580d267a123cc71ca0f2459c797b76fde] Merge tag 'slab-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect bad bdf56c7580d267a123cc71ca0f2459c797b76fde
# good: [355debb83bf79853cde43579f88eed16adb1da29] Merge branches 'context_tracking.15.08.24a', 'csd.lock.15.08.24a', 'nocb.09.09.24a', 'rcutorture.14.08.24a', 'rcustall.09.09.24a', 'srcu.12.08.24a', 'rcu.tasks.14.08.24a', 'rcu_scaling_tests.15.08.24a', 'fixes.12.08.24a' and 'misc.11.08.24a' into next.09.09.24a
git bisect good 355debb83bf79853cde43579f88eed16adb1da29
# good: [067610ebaaec53809794807842a2fcf5f1f5b9eb] Merge tag 'rcu.release.v6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux
git bisect good 067610ebaaec53809794807842a2fcf5f1f5b9eb
# good: [4b7ff9ab98af11a477d50f08382bcc4c2f899926] mm, slab: restore kerneldoc for kmem_cache_create()
git bisect good 4b7ff9ab98af11a477d50f08382bcc4c2f899926
# bad: [a715e94dbda4ece41aac49b7b7ff8ddb55a7fe08] Merge branch 'slab/for-6.12/rcu_barriers' into slab/for-next
git bisect bad a715e94dbda4ece41aac49b7b7ff8ddb55a7fe08
# bad: [b3c34245756adada8a50bdaedbb3965b071c7b0a] kasan: catch invalid free before SLUB reinitializes the object
git bisect bad b3c34245756adada8a50bdaedbb3965b071c7b0a
# good: [2eb14c1c2717396f2fb1e4a4c5a1ec87cdd174f6] mm, slab: reintroduce rcu_barrier() into kmem_cache_destroy()
git bisect good 2eb14c1c2717396f2fb1e4a4c5a1ec87cdd174f6
# good: [6c6c47b063b593785202be158e61fe5c827d6677] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
git bisect good 6c6c47b063b593785202be158e61fe5c827d6677
# bad: [4e1c44b3db79ba910adec32e2e1b920a0e34890a] kunit, slub: add test_kfree_rcu() and test_leak_destroy()
git bisect bad 4e1c44b3db79ba910adec32e2e1b920a0e34890a
# first bad commit: [4e1c44b3db79ba910adec32e2e1b920a0e34890a] kunit, slub: add test_kfree_rcu() and test_leak_destroy()
