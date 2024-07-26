Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3C17CA10;
	Fri, 26 Jul 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015716; cv=none; b=cegGPE6l/6Yon9DCiFEvEAudRrtYOgNz96PBrhy2YzzCl/A0gF3Dlnrf/Xgrj/+GfwRD8gcRTIB6i/PPQfp+jzmIdQ3v5KYw1u1OMBMHEIgHMFeOO5pe7ARtGATby5e4s7EjUEMyqWWV/NGRkbGSuAntZewUFt0nlo5jKkEo4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015716; c=relaxed/simple;
	bh=9KeADtjRMc2/wKa4N3CzPDlV5RmpgI8XHxO9ckOCA/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtmLZieoint27KiXTzDxBWGNNK4mgTVbxcDaqMqzkHQSSv08nB6e2c/p7pXQ7syxKLWf1OH3Bvqrx6UWjymwxb8In7280Iuyy9n4E1aPP6BC7ZG26YWuCNL6EEyhDfLSXEMunNdG22z3s8Mc6h50JIjrZOO8aVDit1kcjFGZryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPQSk0it; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2L9knLhV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPQSk0it";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2L9knLhV"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722015713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KeADtjRMc2/wKa4N3CzPDlV5RmpgI8XHxO9ckOCA/o=;
	b=dPQSk0itszv9fjkXmo6AshX6tC2EtYxlSwnnZIdVWoDF12eo2+y/2SlAsxSDJHf5MY1b2q
	2vWTeCo79+fJ7QF/qS8EcyZKv4jbub9j2Bh/myZVixpRT1ESnUB8E6Hpm/aLzb/l01vZPn
	ypzdEICAPHX9tQgRHssz9kSPNzXTwqHoFBit0hgmuYm/W6KPkQmxa3FJmMDQrvPJRRp9kV
	SsS/dO9KOR2J8X5G7wQBUV88kXMkcKLWOCzyBT/vjpPcZUk7SMRO+6zA5jxJto3ur+EnZe
	crQ7mJrpoxtuAkk2lvE+raNmUwzd7MMpJeP+/jqHN8tHB6wJXmGHPSRgi/imWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722015713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KeADtjRMc2/wKa4N3CzPDlV5RmpgI8XHxO9ckOCA/o=;
	b=2L9knLhVk2wo9m/r1GbNwaAWcbXumZr2kkgY3k7Vf0Oauv6V1RYGYrYpPk5ACqt80+7g1U
	jRVZlWNV8A2ptTBg==
To: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 01/25] treewide: context_tracking: Rename CONTEXT_*
 into CT_STATE_*
In-Reply-To: <20240724144325.3307148-2-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-2-vschneid@redhat.com>
Date: Fri, 26 Jul 2024 19:41:52 +0200
Message-ID: <87ed7guk2n.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24 2024 at 16:43, Valentin Schneider wrote:

> Context tracking state related symbols currently use a mix of the
> CONTEXT_ (e.g. CONTEXT_KERNEL) and CT_SATE_ (e.g. CT_STATE_MASK) prefixes.
>
> Clean up the naming and make the ctx_state enum use the CT_STATE_ prefix.
>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
