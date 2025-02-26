Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F01DE2A9;
	Wed, 26 Feb 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589265; cv=pass; b=OjD1Wfx62Ic3sFRS5EvWY5c+DK2L2vXlVKHoYiMOnlbFwTaUPoHUuk7KvKROUf7jE/gXVAyzYznoMcGJLuPdzTJN+8XPbJ/R7C4yNarPP+C5LEkMzIZiVEewbLxt1zd0s19eqGdHtKkzzJSEkvHzNJRBbcMCQ0k5330frhbNux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589265; c=relaxed/simple;
	bh=rrBHkoNYX1SE8vJwLOW7Vd34VXpCljs+VmhE2AbWq7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jttQeb+HL/IWP2FOlB0NR/0A/96sX6o5SGq/FNkyKYUFzM5yUb4kXoxDYck6NglfFCWOs8MdTHa7++tibSi50BJpCx18eNzq1J3IYHHuLwvBh5/p51j7xnDLXF7gtmsB9pIf0DCwXRCu8YURoVCRw4oOvu5d6UhJ2LLBvA9hqOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=H9Z+9Vz+; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="H9Z+9Vz+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 838FE182736;
	Wed, 26 Feb 2025 17:01:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.105.75.36])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 70770181692;
	Wed, 26 Feb 2025 17:00:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740589258; a=rsa-sha256;
	cv=none;
	b=gNJjOPFNunL1nqCsbTRCRknPIVd6DuX69gifzTsy6zr1snPrBuiysDiTStyyYdUA/Xi5P9
	f/d7SnYoeiOo5/w76XkEjIthRYw7Pme2JUgwjmhZJip2mQQzwM5RSP2DT9GFpkYE1BOYt6
	zW9yU1vTgC9H2PkVMVD6gex2H0Wzu5B4bWhwsdO/Aez2tBJqwkkeCv4OtMTQHOETg5ntZQ
	63gaRc6DNYDuBvLfJQ4IgjgBf4aQoSdZnKZv+/lc+QHGnNYyCScG3+I19RuQLQa0xboYl3
	59VGBnf3amxjwSIQBWW7uh4Dh/774sCPKILsKDyB7n0G31Yz6DS0Uzp/4+xlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740589258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rrBHkoNYX1SE8vJwLOW7Vd34VXpCljs+VmhE2AbWq7Q=;
	b=wYuXiHFQN8vBbFXELBqFKIdFnXwaZ+SvvpYlj1tNiCoPQ047ngoYkPMY7NB6Yi963IVZLf
	nDBUfItUc4hLZ3jLSzhUtjfde77cwehG2XAsRO9yMafRN8b681JN6GZPpBbSlzkypPyOK7
	7hoCoyxqrdE7kn5ao7PlgDXKEM9rrlhifUSu5YV1fXBSjqesRBDHBK39pPqaNNc+GBXLXX
	RiAW08o/tYq7KSzcBLXW/ASzwEkbIxbx4+L1sXOns25+lmZZbclQdT1tLmDDUDNwAtod3X
	Oo8SyOoCZGT9XoKtGKacG2xeyTzof4dPj/IXGSO/Kr5ueyJ1FyJyWWhPX4Tgjg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-q7f2g;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Army: 07a574fa4dec4754_1740589259053_1304349702
X-MC-Loop-Signature: 1740589259053:1725531657
X-MC-Ingress-Time: 1740589259053
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.75.36 (trex/7.0.2);
	Wed, 26 Feb 2025 17:00:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Z312K32h6z3d;
	Wed, 26 Feb 2025 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740589258;
	bh=rrBHkoNYX1SE8vJwLOW7Vd34VXpCljs+VmhE2AbWq7Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=H9Z+9Vz+cD+MI0Pi9BowQUIIe0YJ/pcjIXzsZElUUQwt48i4fukX0C1XtiYX/8E9n
	 KFsRP216yCoNSmcAQx6aaq+nt5L9b7zk/zvov0kzU1ucYiXYYcIr17geZqofGYPB9E
	 7CZ6MlfAUTsHjq7k1VWNhPteHHQsPSwQ1fvaMlp/vTN0lVA7Ir+rTPGoiAMOgAaJv6
	 BS1q8azoySijrHL1iqMv4TaGT6tKcGyR4DA12BUMjt4LN28ET5/AIIGRmgNvMnvpqg
	 P+hr59fJZmlvO3tSIPeCDEY6mvOF4vK2x00fe+spu29gFFjyKvOsdx2IxAWaObUw+D
	 qIPWGENLtOC0g==
Date: Wed, 26 Feb 2025 09:00:53 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250226170053.lxpreaegz5tysef7@offworld>
Mail-Followup-To: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
User-Agent: NeoMutt/20220429

On Fri, 14 Feb 2025, Vlastimil Babka wrote:

>From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
>In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
>critical section, but it doesn't prevent NMI, so the fully reentrant
>code cannot use local_lock_irqsave() for exclusive access.
>
>Introduce localtry_lock_t and localtry_lock_irqsave() that
>disables interrupts and sets acquired=1, so localtry_lock_irqsave()
>from NMI attempting to acquire the same lock will return false.
>
>In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
>Map localtry_lock_irqsave() to preemptible spin_trylock().
>When in hard IRQ or NMI return false right away, since
>spin_trylock() is not safe due to PI issues.
>
>Note there is no need to use local_inc for acquired variable,
>since it's a percpu variable with strict nesting scopes.
>

LGTM.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
