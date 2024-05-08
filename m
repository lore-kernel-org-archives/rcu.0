Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29853389;
	Wed,  8 May 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172190; cv=none; b=dvwfIqrk7wWuIDgT9aGoxDNTNEULoLv2ugN68VFS6JhjdBafpbfifDKegZPuBTMAUTVV5riCUp6hi/uv2PsknEf4g9SPzNWTh3L99zCNbO1cyWOPXZ8WO4TSnCGfI8s93v4gnJCkQDPaqxniaBOAHIxIcNmaFwKv3PcShw4g2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172190; c=relaxed/simple;
	bh=8NznVt9uPi6IEi1r9uBabIZRu6f3XtO+FBTx7N7wvXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXHcTEFiOcWwioMlyAMip9/BsbcC1ABOG5hjaU3QVIe2ih70Rc29s0BtZXy2cYz5i7A6VZp5z+XYLS3zW+KjlLV25b839OX/WPovaGYTS2SKt97r1e41LNW2IDoa8D5SYyIsWoIiNteK4Va1GqZzZdi1VUsU6puclwsXYSfHZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9TL9CP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9TL9CP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D205C113CC;
	Wed,  8 May 2024 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172189;
	bh=8NznVt9uPi6IEi1r9uBabIZRu6f3XtO+FBTx7N7wvXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9TL9CP52vkUEugxVd+ArEH9O9Lbl6QQMrmv++sWbokvxJ8IBeUD21sbMQ7vb1MvZ
	 D0wQG/QT42JjwMmvHvuvwEvjw8/hGkOyLA/Df7pPa3h4C4cNVz6rqkRFOpVkmv7Tl4
	 fjtCz+1NDLY7osiXtGeSP9SJLI2rJcEer2b6rFThzO6QxdsF12aFgSgAT5dkW8oE2n
	 denGyU0C80Y5xsn164PkFfswJce6QB2z++/aTvojeyG/VpX7tXOMd4KOdH24ue5RfQ
	 /VcA15L59AxP8TOijgYcQm/Fs7N9ZpmeP41b+pgwRTXptMoRW8ERHP3P5fe6RgNPwo
	 g1CtvnPvc1wJw==
Date: Wed, 8 May 2024 14:43:06 +0200
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
Subject: Re: [PATCH v2 19/27] rcu: Rename rcu_dynticks_zero_in_eqs() into
 rcu_watching_zero_in_eqs()
Message-ID: <ZjtzWjQbg8jwflYk@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-20-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-20-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:23AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
