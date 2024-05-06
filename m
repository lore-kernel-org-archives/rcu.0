Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67D158D66;
	Mon,  6 May 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030140; cv=none; b=IHzN6On82j0nqUThpUAcRDeM+u3Vny/BUgUnBJ33RY0qbL7vI2jzSPNogU2qKhRQ6HwbpbslsUmH61Jxxu5b1MXMBrm9sj/F89Jaicc5eqS0rRfPUxyYDtXR1VTaur+ja8itukX3pDu4yTTAPeJ8BrA+Lg/MSq2rUUtl6qe6LKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030140; c=relaxed/simple;
	bh=BNEt0fBHSji1sSptkwjldcVnD1m8WbokH54t5xvjJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdbo+36Jfv68RYKdXQWgkFU9EtpTpeAKM5dr/27bBcgsPaHwDy/Ty1weRe0iH3VxEqnH2xDpPou/qWE46x1d7j+PkSzlo6g5V74TdSEy/I6Vi6l3BiNy1zlecttiSprwAajLwSbxHPqvTIAiJX7XT2ftylFldzSHFXhv6gfhX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqKkkhkV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqKkkhkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D032C116B1;
	Mon,  6 May 2024 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715030140;
	bh=BNEt0fBHSji1sSptkwjldcVnD1m8WbokH54t5xvjJJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqKkkhkVq0BxlhsNJ/a2Z2dc2C7JFP9T4n6PqpAfWWugRBtOBffKz6zc21pEozzUR
	 lVy0LuC1DuGo+NoeTYaNsnLHSeCXV9denfhtal87Nym/azFZd4s3wQXq5VQuKbpSGX
	 cOcA2OUBA8KjfKWSkCsQ0NVCgHKbq9cHoOOMNrYRtWm7MxPMOlkzewNIu+HvJnQdDH
	 J3cZ9H/JqUuDmrQ/QnUDTPdA8VOIotQmipcb0Q6FXRAEkuJ0Y+R/7Pps1NjkqwFo7s
	 tfHWmR1wrtrxCL0TnkSNSTKOoKJop/KJKK3Xpzzcck1jPSZy1u/3pc/z+6E3DJEIpl
	 sYxIUbqjJW4pA==
Date: Mon, 6 May 2024 23:15:37 +0200
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
Subject: Re: [PATCH v2 13/27] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
Message-ID: <ZjlIeVR2zUuNhKSK@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-14-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:17AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
