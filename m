Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2F239584;
	Wed, 26 Feb 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598129; cv=pass; b=SK4hY2gFETscQTTAYcZOq8+PP6OYuy8u4FOaMor1MgLrEBFowxAVRJEdd6bud8Jx/l41BrYyhK9MtGYWiOVhgWh4LxHN4oASGoAbNhhJ+tJ3wSvHK+Yf3QmE/UFhXKqRy93Rv1ARjYIsaiVH5AcgwxhjTi7KnfjIdQbSWeTarAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598129; c=relaxed/simple;
	bh=pYIw9z3bS5deLOWEgf2733YFTI87p9O1CnGmqE0gF08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUZq6UMznYvEDLudCoh0nI4n9qF4jkPhNXbn7cg7fLArC75wR6ZD9dzrGD9O4Gz68Rx7rpbPTQ9vd08Iez97T12+tYv6YHTYYZh4XpdJXIyEQhMuPYbobaZKq20PxTn1dXfndXqzTkwOeqKS7jUt5us0DFLbKNz9XQhmjNHVXVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mkc0h+Lv; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mkc0h+Lv"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0EB399054F5;
	Wed, 26 Feb 2025 19:28:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (100-99-192-59.trex-nlb.outbound.svc.cluster.local [100.99.192.59])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 85BE3903CC7;
	Wed, 26 Feb 2025 19:28:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740598120; a=rsa-sha256;
	cv=none;
	b=OKAz95KvTk5hRyDwD7osiCT/FD/FEjnfvSK3cZaf4w8vDvr4iOaCnc8iMFisKIXctETH9m
	4CiUXoBk/m9tIB5C831nwrJOeHmb0Iky7c6n68rRnbEDT4T6n/atUO1HB96j+ClQ3qVklr
	Ch0pMX0RFFRe8XceTwPo2mKcFXcVnBKK4AFBB49oNWIold7L3tyswycOLhEZCl18gkZhWk
	xJRU//KP/8EjznmlDjm2JkYNawmf8V+LqfHLpcD8hwwzb3hda5lqtqs2r5FwHzbEXazgAW
	hKyK7QJKqzeyxa33WiUTjAJ8wZrgBUPvAT+FtKOf7hsi4io2qf3cMI3UmjiaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740598120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pYIw9z3bS5deLOWEgf2733YFTI87p9O1CnGmqE0gF08=;
	b=UWQRn6xsASkGBMAtFOr/ULkhbwi1IpSOwjhH86ZbdrwhTE61imWUpb2iyKM9npq5EcUGAn
	LyRJRWqDN9hXK6RLhmIBeKl2/wkzKSMHKYvTc/iocQMbcgIeU+Dyc9PmUf0OVRmWu0AQPS
	pkiPLPVxCtjbZ/vLa0OyGsgVKPZbDB+bmK2Ee1D45ulnC4K3RO5R8qH0BrNp6O/G7Sjl6+
	3kVr23g6aq9wyCtCae3ulKKolU8Jd9nWUjYmF8oA4DMHbbcMtLPRl314sQLOpzTO71MgRe
	Zd5C3g2h74czoGSuUEeToI/aPDOc4RU26HeKflI+IisA1CYPfr9qtWLSR9JNlQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-jpb69;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Squirrel: 7e800a0258e359d8_1740598120877_3242746971
X-MC-Loop-Signature: 1740598120877:4221620723
X-MC-Ingress-Time: 1740598120877
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.59 (trex/7.0.2);
	Wed, 26 Feb 2025 19:28:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4Z34Jl41B8zLF;
	Wed, 26 Feb 2025 11:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740598120;
	bh=pYIw9z3bS5deLOWEgf2733YFTI87p9O1CnGmqE0gF08=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mkc0h+Lv2m2i8Hp/ny7cTPnrR/Rj06rgBp19qbgM+HJkUxv4+L7sNLswOk1B+LvPW
	 Hr5aiWVaS+rtM/rLs3zK92JGFKVRBVUm41EGuEVNzWT0itjZGxW70SJfEkWQr+iZgY
	 kdKj1/z1jYwQRFhpy2Wvxj8hl//mgctMgkBfk4rB+3hmNF6Hg6669l0tzAx7Hh/QiJ
	 61hmzUNp0hVBL7EOmEF7ylfynogImtwg9gI+QwADgUCmjeiiR4oYn8saabBknSlfZq
	 ikU24o3LalQBplB+pTzYYrCmPApZqou/d3a0GGanJ74pHq5BRVaC9ArYVNYeYOW+aT
	 sr28ct+tivzmw==
Date: Wed, 26 Feb 2025 11:28:35 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250226192835.bmehafm2rjcbq42z@offworld>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
 <20250226170053.lxpreaegz5tysef7@offworld>
 <CAADnVQLAfZBvSyqE=2sbdH-kuNhvAJM+R_qMzfgPv=MDF+=VQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAADnVQLAfZBvSyqE=2sbdH-kuNhvAJM+R_qMzfgPv=MDF+=VQA@mail.gmail.com>
User-Agent: NeoMutt/20220429

On Wed, 26 Feb 2025, Alexei Starovoitov wrote:

>On Wed, Feb 26, 2025 at 9:01???AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> On Fri, 14 Feb 2025, Vlastimil Babka wrote:
>>
>> >From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >
>> >In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
>> >critical section, but it doesn't prevent NMI, so the fully reentrant
>> >code cannot use local_lock_irqsave() for exclusive access.
>> >
>> >Introduce localtry_lock_t and localtry_lock_irqsave() that
>> >disables interrupts and sets acquired=1, so localtry_lock_irqsave()
>> >from NMI attempting to acquire the same lock will return false.
>> >
>> >In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
>> >Map localtry_lock_irqsave() to preemptible spin_trylock().
>> >When in hard IRQ or NMI return false right away, since
>> >spin_trylock() is not safe due to PI issues.
>> >
>> >Note there is no need to use local_inc for acquired variable,
>> >since it's a percpu variable with strict nesting scopes.
>> >
>>
>> LGTM.
>>
>> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Thanks for the review.
>Do you mind if I apply your ack to the latest version of this patch?
>https://lore.kernel.org/bpf/20250222024427.30294-2-alexei.starovoitov@gmail.com/

Yes, that is fine.

Thanks,
Davidlohr
