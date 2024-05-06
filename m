Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9A15B0FC;
	Mon,  6 May 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032823; cv=none; b=AipHy1vio+ISW/3qXYDu+Rye7MkUT21hDU/rR3GYFak9ERAfOh1sziOSKM4oy0yOzEEzaUmXhc9JpdkaBOS5L/KTQxA17khcQMW60eg0Vs3s/ZsgwEwPoKm8hUfRYAdjIO0eTK+OI8ZPuvxZpJNuJDfuDwSoSA0d1LZe+qjFENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032823; c=relaxed/simple;
	bh=DGEjDoGjnlISUZT7qTrHLboAC4L73+JN3s87SW3BNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTALdb1MqONeTx20xSfRjReyEdP6P7eO31+W3hbgGedIQc/junV9XIdZ+1S/QF7xqd2ms6oeH7/BrF2WiaICDaceCgWEN/kT7ngXK0vGE7eaVu/FBCnlSQmAhMtQlF0wgmQ6MTOkyMuZsst/WAR3caHx9TE7TgZD66HntLwNRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na6oz4cx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na6oz4cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C3AC116B1;
	Mon,  6 May 2024 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715032823;
	bh=DGEjDoGjnlISUZT7qTrHLboAC4L73+JN3s87SW3BNn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na6oz4cx/U5ziqjLCkf+PAPo68yTD9dUjn40ucK+CFFkMDq2blWKVkPbCWviYnHd7
	 9LdDdK1BqD1FHocusI8EfiRsx1DqSDfd6a1rr52l+tE6Cq/C6dKLwrNFJpf3NT3r2n
	 l/xbOQbR+f8UapkmXCM2Taf+06JqtVjKPCyFkhAECer6MwGHusgieTM1AODQqe3Swj
	 708OisB3H6CbJEk+mn0ZLK3ckV93Wowtf5rDtoTbwV8JSy8G8XOuPtn5wTQZmfq3Gm
	 TSQLelcmeK4Li+7UuTe1NU5vRnm4YO2zEp7j3m1xteDNyOJevCga5tj2pYwcuL1AGm
	 7d/C+Q2Y+zUXg==
Date: Tue, 7 May 2024 00:00:20 +0200
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
Subject: Re: [PATCH v2 14/27] context_tracking, rcu: Rename
 rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
Message-ID: <ZjlS9Jktyy7LNwuP@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-15-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-15-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:18AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Note that "watching" is the opposite of "in EQS", so the negation is lifted
> out of the helper and into the callsites.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
