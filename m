Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BA56B76;
	Mon,  6 May 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026747; cv=none; b=lq9+pN74VcPsQarAz0VCkNGu/SyB++5TA+KWpTK8b66pxMKwpNQyR3mtpEqNZhwTPeyDZRS2Rnnjpc0rGW+sjyalt2mOaJbSC/skrEyWL/uEVUAN+ce8fnXYLQ5FSJoKBWZkHIYTd38lRU0pEobXgJVtRiASPPJ8rS3LK6twSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026747; c=relaxed/simple;
	bh=lzXxXLv20XOzIaiflh8ms8ykbiel/WpH3fDRKY0ciLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THJuAzyWDd9FnGSbW6XdqMniuATzZJzwaPTcsThLHiUY17w+TokSW1wFihUT8JPen4ziR6fnnWnYKugZub9XhEYnRbtgLhEoi4QRsTsV8rktW+gPxknRgCi+lW3rM38K2+26fdWM+oaM4DZa7MhGUb3DBUuCI7S7L5QUHbaTJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcGJubGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcGJubGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE42C116B1;
	Mon,  6 May 2024 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715026747;
	bh=lzXxXLv20XOzIaiflh8ms8ykbiel/WpH3fDRKY0ciLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcGJubGenqt5PC81aAqSozWAyDQibyHP42aNoxGqFTBzDmp2qjXMuYWJ2Ff0oAaIi
	 tw6LSA/WrBeSMvZuptFXnYsBcw6PmZPLf1GvlezBGoYLnli0JYRZXktY5EFvAAgmWJ
	 X8s7qzofnQqjMVwdv0/osXYfzDuSAZirW5P1u1a1iM/Y9WNGiYDqvoT7cz1r5G/o+R
	 iXcFe4fNwjWyDpER+MbesfDVG+KePCO8M8iA+kSXp0Mxxo8cYwI7nzv8cJWBAmjZWs
	 h+xZa43OLA90MbZYfvu6K8e6qMqIxDY55qBxoyoNj9a+JHyAPVrEJfkkdQexJz3tqs
	 t/JBupJhr53lw==
Date: Mon, 6 May 2024 22:19:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 09/27] context_tracking, rcu: Rename struct
 context_tracking .dynticks_nmi_nesting into .nmi_nesting
Message-ID: <Zjk7ONFGA-B_sG6k@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-10-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-10-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:13AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
