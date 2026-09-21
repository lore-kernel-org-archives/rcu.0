Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAC484238
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989718; cv=none; b=l3IwTwKQit8wgW+t12RaCfkN28WU3Kp8xhHDjOVAJKkhC6RmiZGeaxvTjAcQd8yA6OsVN0/67dfG5naWmbg3HzSHfur07UC0S7cHgNx0oW0ppdGFCHwdOxR3tbcgv99C97ZbDZX2icfrnhfzYUjMPuY7oLXw/WmkvkA38E8dnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989718; c=relaxed/simple;
	bh=nj4Q6OP6SoK8Ru9viwCVYiVJtMzO5g5yi9lAI9DKHy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9dEG7B3gvoEpGK3N1+ekiQDb31d1Y7sYf7JyKpF/F4rhLnYsbWgKCgT++SWngsFjqn4NIIjeslcnOTaO9lGdF9wfugS+6A027XBXzYR6uqkG3YMHpoNnYhw+ZyuJ+ddljy7aWZDnJ8y3b40W49fnjvfCY1x4OjbdsGGWj0H/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Rzu5YEYN; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Rzu5YEYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1789989714;
	bh=sg4eS4lg800FfNdEgDSoTx4BTb4bxIyvFHi59GLWpus=;
	h=From:Subject:Date:Message-ID;
	b=Rzu5YEYN8XXF2G78r62AwufVqkFZR1R+GyvF7KtJvdLntFCwogQzdqxGVLNBHvcIo
	 4WWrh1ELnUBrGtw1b2lN7XAo900JI8D6C3PHcjNCjY+6iqfmNT/IAlYeGVJU8TytsO
	 pqPEUFsv7n8AGEcGwBac9f5xQS+g62RC44C4JpHo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.33) with ESMTP
	id 6AB11343000012E8; Mon, 21 Sep 2026 19:21:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5185206685057
X-SMAIL-UIID: FB65B8A53C8748DCAF25A55AC2A44BA8-20260921-192142-1
From: Hillf Danton <hdanton@sina.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
Date: Mon, 21 Sep 2026 19:21:30 +0800
Message-ID: <20260921112131.274-1-hdanton@sina.com>
In-Reply-To: <272c0fdf9e5eb9a1caf6a5c0bf674e3c006ac2ea.camel@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 11:54:36 +0200 David Woodhouse wrote:
> On Mon, 2026-09-21 at 09:42 +0800, Hillf Danton wrote:
> > On Sun, 20 Sep 2026 21:49:29 +0100 David Woodhouse wrote:
> > > 
> > > Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
> > > domain (kvm->gpc_srcu) for the read side. Readers now run under
> > > srcu_read_lock_atomic() alone — preemption disabled and non-blocking
> > > enforced, which every GPC read-side section already satisfied as a
> > > former rwlock critical section. It works in any context
> > > (including hardirq and sched-out paths) and never fails or spins,
> > > eliminating the
> > > read_trylock() contortions in the atomic paths, the double-lock dance
> > > with the lockdep subclass hack in the runstate update, and the
> > > PREEMPT_RT problems inherent to taking an rwlock in those contexts.
> > > In particular, kvm_xen_set_evtchn_fast() is called from hardirq
> > > context (timer callback, kvm_arch_set_irq_inatomic()), where taking
> > > gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.
> >
> > Given the preempt_disable() in srcu_read_lock_atomic(), as PREEMPT_RT
> > has no way of handling preempt_disable(), you need to add another
> > version of srcu_read_lock_atomic() with preempt_disable() replaced with
> > something like rcu_read_lock().
> 
> Hm? What's wrong with preempt_disable()? It works OK, but is generally

How is preempt_disable() handled by RT?

> frowned upon in RT unless the sections are short and bounded of course.
> 
Is this patchset going not to work with the preempt_disable() in
srcu_read_lock_atomic() replaced with rcu_read_lock()?
