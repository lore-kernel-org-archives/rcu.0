Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB35EBB;
	Mon,  6 May 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028657; cv=none; b=DRQOxddGW7V/tJxpANrtBNAKmvqryXRGjqjmNuyHgIFwJZp1FQxgyQ9Qe4aSQaDKegBl2eszKGlpma0LLyyjN/A4LHX74jfvBxjn664gs6EF2dRx8dnnrFU6vgylj258tBqp7bRBarfVlHS9lX+kKUXmt18Yk73EGVsCwMZbhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028657; c=relaxed/simple;
	bh=UP8lkkLRcn6o8Nws3i+PC8kVXU9fbwwXDlkp5t6Rl8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYWExumHP6FJrXdbitNiwLL+Fk5bBE/to1OFmtCJ9btAx32AHWuMEinHbTZhunsdaI+Muqhas1h0W0XVRLJVnyRvdHggeRrgr4ZOeSj1nRJJJ7BrOgflRhjYsiFyqRbwfTBG2nXpoMrgii7ojRgT8av1NDKFsrJfkWUF1V8H6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWtud+9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWtud+9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B30C116B1;
	Mon,  6 May 2024 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028657;
	bh=UP8lkkLRcn6o8Nws3i+PC8kVXU9fbwwXDlkp5t6Rl8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWtud+9MbrQcATt6P64gb3M2YUiMCt4hN9XxhjcG5AWtZJGaBDRWYNDcueUkDv+70
	 velrJJdzGV8XKbZvjqr0zYhgkSM7ejZoYk1wMo4srr0nWOG8TMDGoIjb+0eh6OzVBX
	 EWVsc/egGXXOE1XLbCr5WjqFWb4JcvTw/nPad3QzGVb5kfCwhb4fm/Igfc3KrzxVb3
	 p+q+lRyvnBMMcPg4JyAsscO6FwgXd7Hlb9PTGAu3eLn7FGccXRT1EQeS7joqhQLKYF
	 lAZ0SMZYWwhF6z/eJtaMiv6WK9s4VPGrmykkK02RE2+FMVwEOkictszQ9dceZC3P+k
	 K9186Gz+T7YLw==
Date: Mon, 6 May 2024 22:50:54 +0200
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
Subject: Re: [PATCH v2 10/27] context_tracking, rcu: Rename
 ct_dynticks_nmi_nesting() into ct_nmi_nesting()
Message-ID: <ZjlCriNSsyfPfhpd@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-11-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-11-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:14AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
