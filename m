Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554923;
	b=Rbu/0x2pqg/oz+iSbrnrB3GsqKvYMynj6PVx49HsimLNaqJ2xxBUENtE4pDOHyqZJj/n
	 2GaIv7EZAn4vH58kKwSPOy5MmoYyYe34a33UQE0Z5USRfSGZ7Fd8eAwX8byHZMjSh4hz2
	 N5iK/GlGSZYfam7ofiy/184jH/iq2RmH9gbf65+Jk//sjsvHBoaCapRg8tiqHGRejZgAp
	 6jS4vUebthnb+p8ZyaR5Esw8AE5VKo+xwg6UH1nPXnn5Om+UL+37kEJZ0uXRFPrI3HQGk
	 w8svgePaFawHaRYwBvAktjWuuAgbapkgc++1WQUE93G4ZwXIfp4GifihfsT4S0EInNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554923;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uV1RlSUlJhp7RT3cxtxzLkPGyx/lW7hv82YH9EY1uj0=;
	b=ieTjGvfKgebGyGTivUxIUPFDGs/D+o1KOV5PLZtvdHBfwchUekRl7NvWm2pItmUJTvjJ
	 zYd3jokhTtVZBr+p3UJnsDYmr2ZaHXPZ4ZJMQAsZlNHhSkx0WXKI+L9LCmUKtu8gQpdZG
	 mwqquHnA3xfgHR0wTVRZqbrfdyBQg8a7soiTL2b9jQ/vfJf/7fboDn9IIK5R/6dvcLv4+
	 p/fW1288wlbG6g1egic9EK/TTIgCuNC6XjLdlP8/ybIMyDiFIMfbFPGqudeVA6kj+aojE
	 q3xHdtZ9BTvLES8Ay6Ij2MgvvpbzhcVYG1iz64sGXEu38aZe3aph8aTnvo2LqI1kMwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFoJc38z;
	arc=none smtp.remote-ip=91.218.175.197
Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AC606A321
	for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 07:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFoJc38z
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PL+49LzgHmYCQSYK6PQrkS7oOVyvTcbSDgS3yZVtfH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794554920; v=1; x=1795159720;
 b=nFoJc38z/N47emVEkuBXnpIegfzSjNB+RhdWZOw2n7+HWiUq8YdpXup0t+MzSZnjI/s8F3g6
 JzIqik2flryO2yCFPCDyM+VtL9m0HKdxHmoD3+hBDENjnzegAZj/urs+6zzTJUiuhi5aK9cPyY0
 tj1WdzZNyYB0uIWcgwXD2c4g=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed0c2e8eb98fdb13;
	Fri, 13 Nov 2026 07:28:40 +0000
X-Mizu-Trace-ID: ed0c2e8eb98fdb13
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 07:28:41 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: jfern@kernel.org
CC: boqun@kernel.org, frederic@kernel.org, jiangshanlai@gmail.com,
 josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH for-v7.5 00/14] RCU tests patches for v7.5
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
Message-ID: <5F3EC480-DEBB-437D-B433-2361A5CC05E0@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 13 November 2026 00:57:27 GMT, Joel Fernandes <jfern@kernel.org> wrote:
>This series has the RCU tests patches for the v7.5 merge window.

Thanx for keeping my tags, mind changing my tags to my new email? If it
doesn't pain you too much? New email change is a pain... 

>
>Fu Wenxin (1):
>  rcutorture: Fix busted_srcud crash on module unload
>
>Joel Fernandes (5):
>  kasan: Avoid an unrelated RCU warning in the callback test
>  rcuscale: Consolidate per-writer arrays into struct writer_state
>  scftorture: Reject empty workloads before starting helpers
>  scftorture: Protect the initial affinity check from hotplug
>  torture: Forgive SMT-control failures in CPU-hotplug testing
>
>Kunwu Chan (3):
>  Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
>  Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
>  rcuscale: Add srcua scale type
>
>Paul E. McKenney (2):
>  rcutorture: Enable RCU_BOOST where supported
>  rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios
>
>Zqiang (3):
>  rcutorture: Fix suspicious rcu_dereference_check() usage for
>    trivial-preempt
>  rcutorture: Make tasks-tracing support duplicate call testing
>  rcutorture: Avoid create fwd_prog_tasks for tasks-rude and srcu-atomic
>
>

--- Thanks!
