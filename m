Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B4346A1C
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305361; cv=none; b=JtTSOfdfBX5n6weY79pRwRPuZ5B1L9b7ZmwRaG6wsOe4iBYCt3hlPS7hEA0U6Dar/3oQWaF8QAMCWN7+7LHHstd6qoy+isTxDFo8ZXW9A/6ZDTA1Z8dd+JiFhWhwNXxEIbBoz74JQj/BGvFmTeqXiSy8nFHbLZcmTzManPOPL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305361; c=relaxed/simple;
	bh=CybBkUF9PqqrkXon4a/OotVsf6egaS9WEDxo0coSCCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSom79BNPFf0Vodww6yXYd1VNI1DoF/fDkPDVQ3UodY5+itgBXt4BCi7J/C9oQU1d6fPrs+ilWLLjU+B+9zmGNeFTFmX+L6wDFfgFGIEfr+w/G70wON3eAtMSlrLmm82tAsvD829WuEt4aws79MUsfj30IjLCoZA/9KpS9UpnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbh7pNvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbh7pNvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF07FC2BCC4;
	Mon, 27 Apr 2026 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777305361;
	bh=CybBkUF9PqqrkXon4a/OotVsf6egaS9WEDxo0coSCCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dbh7pNvlqujxe5FnKHZ43oaR7DpNHmV0YkHnDdqyjresMN5AOnx900oedYNP3oT1v
	 Z9WHVsu0W9QrObQNcQr/NCTzwuncqFQsnSYonWUK+MONsi6XRg1/gEw/FD49bbQvBZ
	 1QdY3zu572TlcvnLusTsZbJ9sxkYgiK91W2nGjFkCUAD7ErCpwxvqHhTRWHC2qUK5c
	 zpa8bT4spd52AzUbXp72p9qWThv34zzy69hKfFeIq2IRs52DRIUZBU3OTsxTpSUkmI
	 +tddMYK4syoRbwSVzUDf/yAaSbOoTFaJtNxue/WH/A/bdZNmr5VR7zQ3Ri3EsXzDOZ
	 g4Plm6qqbl0QA==
Message-ID: <52506ad5-99fe-4686-86bd-6d9e38b5ae36@kernel.org>
Date: Mon, 27 Apr 2026 17:55:55 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] mm/slab: introduce deferred submission of rcu sheaves
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-8-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-8-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> Instead of falling back when the rcu sheaf becomes full, implement
> deferred submission of rcu sheaves. If kfree_rcu_sheaf() is invoked
> by kfree_rcu_nolock() (!allow_spin) and IRQs are disabled, the CPU might
> be in the middle of call_rcu() and thus defer call_rcu() with irq_work.

Seems like we're doing two things here. Implementing a fallback is the
advertised one. But also narrowing the definition of "unknown context where
call_rcu() is unsafe" to mean irqs_disabled().

Where does that condition (!irqs_disabled() means we're safe) come from
exactly, does RCU guarantee it anywhere? And if that condition is indeed
reliable, shouldn't it have been used by patch 5 already?

> Submit all deferred RCU sheaves to call_rcu() before calling
> rcu_barrier() to ensure the promise of kvfree_rcu_barrier().
> 
> An alternative approach could be to implement this in the RCU subsystem,
> tracking if it's safe to call call_rcu() and allowing falling back to
> deferred call_rcu() at the cost of more expensive rcu_barrier() calls.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
