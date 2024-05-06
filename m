Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B8446AC;
	Mon,  6 May 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029429; cv=none; b=T1+6WpRXSraPUa1hCH+LFX4eqqDJymSiusWvQ802ZGUd/UiQG9y9Mq9Q58P1/Dk2YVxKuOOBtaHFJc/9M7lFvhWcnNyJLAuoafCYDgU89OboQxMYpWcIiISI3selBkKhIU+5vp1iB2DLC+hyG7kBYglsNTtYTRGiQYGFSXriiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029429; c=relaxed/simple;
	bh=7rhOkNHOwCbYTHrQF9O/4r78By5ipU6JTmaE65MXYoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWjpGjlO2qocyZGrynGa9tnSzTA6Y6jjTsvH7ZmZ891rbB+YwEwmCmRPH6ZWZw/KCiztQVT02BdmWb/7BmxlT0LglRbEx8T/P2l7WDCHHi1HMQwEseLdhOLKcgBMB5y0uDobJjgaloqWjNNP4X90WAXeCJw06VmhiVlDo99vS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF/DClCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF/DClCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213ECC116B1;
	Mon,  6 May 2024 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715029428;
	bh=7rhOkNHOwCbYTHrQF9O/4r78By5ipU6JTmaE65MXYoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pF/DClCpBkSB3mzVy3MantgcwU+JxCl332PF2ZxIR63A0VHgLpGFEGnI9kJLHdz+M
	 GGt/J5vQ8W/JO3gAaiaxaYI+DGPhFdKVUa+ooca02tfQVW1U7olWlrBqNg5VrIiN54
	 5R3eC+Eo0SIWnvpE4PFzdz9NK8bK1OTB547Ox2dmYejJmwRuryY2CZ9D1V6D11DKyV
	 bTxIgEWeOjfxFSb56aDeSY0uLHpQPHo1QkZuRrsMKJVfpDoJFnPMwXnxU+Kl46gDKw
	 dGnba78coEwe4CPouSwH9HOpfgkHqVbOEfCNi2b4fpYx40xcAhcIAgxDY3Yyksw3D9
	 JOIj048mWCDQw==
Date: Mon, 6 May 2024 23:03:45 +0200
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
Subject: Re: [PATCH v2 11/27] context_tracking, rcu: Rename
 ct_dynticks_nmi_nesting_cpu() into ct_nmi_nesting_cpu()
Message-ID: <ZjlFsUEEqjchDGE4@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-12-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-12-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:15AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
