Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CA15DBB9;
	Tue,  7 May 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087492; cv=none; b=YgkxST5g57GEudVvyrD32PBQGyU9US25SzcaWaGqZSas383ypPOiz3q44+Z2iGfm0uw/lFbERFDWiCpjMw5NIRcspkxJqn5jegGW9NqkUpVNkhFwJgL89RcPxYIY8d2mqCPWfRXj6rv/KRX1Q0Cz9qbENt3RUy+BcJFH5hkcw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087492; c=relaxed/simple;
	bh=AerjoA16ifkt+w7gQAm7UDwlvJXI2Arc2QWZpKi8VsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8ah3QX7/8AWeBN2reOKiXouQ8BKFV1X51mOoZIpiKVdXAJMC8s4ZDLp1m4KUc88PKda6bJTt3bZHywJ2rwK3R6raPvPoa6Vp1GFuzGOlujid56w3x2czCgN45WcVqR7JzCT0v3LtlL4yiq47VrX+Ocq3IoOin+0fSY4ak//V/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC6mRpHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC6mRpHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73396C3277B;
	Tue,  7 May 2024 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087491;
	bh=AerjoA16ifkt+w7gQAm7UDwlvJXI2Arc2QWZpKi8VsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC6mRpHlT29x11ZIDA08O9QkEDb8LpSKFs+I0SzTccIrSUz7txP7TkKLkt8QSFiQ0
	 zy4D7uhdEarVJ4FEJSeeFWqt6Xk7hWu07+TyKK4LgJHNqovZrWOX95fxVS6MUXS8Jz
	 UDemTkpdD0n8EHnAMdvuF1tLdEzfh6SRIcDd7C6RN+Yd/Daxt+uUkquqEEhgnx/HRL
	 Ozj9/XtFM3dyGKjfEJNNdjYC+O+OfMWJ/DnptWvmz+inLoY9qUDs8YlfceOYX8xfQ9
	 4bpGsEPk8Se2I6E0NtvCnhkg/wmbYH3PXsK9bkusHRbxCFRb7BxTsyVPOw3ZDopAsV
	 Xc83cG3j2GGfw==
Date: Tue, 7 May 2024 15:11:27 +0200
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
Subject: Re: [PATCH v2 16/27] rcu: Rename rcu_dynticks_snap() into
 rcu_watching_snap()
Message-ID: <Zjoof8-Qm2Q92uS5@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-17-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-17-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:20AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
