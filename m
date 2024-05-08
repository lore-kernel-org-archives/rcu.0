Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CF26AFF;
	Wed,  8 May 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173615; cv=none; b=kIyXoWz+eKUMKazd5Rbd6kJKKJrnufk9vm/Iexsw6wxLHJ5rOHO7BooRjtwIAiymU4zO1SskdrpSDzGqpvJWwtqLDxnAO9t/z12gi9SVIDWi0c+5bdhtPhw+FJn4gIhPrzlMDXxEsJPVIBkPyyV64BeDm6ICasobi9iqCwTaXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173615; c=relaxed/simple;
	bh=wxrbLWYR2RDMbgrriDlFkNg1XI9Uqz7u1olNwaD5+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf2UvBP+GNX1cbFOaJ8MXXDCeXTuxmy/6bY5Nchrsd8hZqa4IO/eAZs2wtss0ppwW92eoMIem3eU8JCUQS7fqPjUVCmZOb49oFe8cqQVNckca+zVLl6MdA9pRirRMan1XGhjGfMKT1F1gg2KcyiAZyl0EXih904viGVgpW16O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQXn3Vll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQXn3Vll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BAC113CC;
	Wed,  8 May 2024 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715173615;
	bh=wxrbLWYR2RDMbgrriDlFkNg1XI9Uqz7u1olNwaD5+30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQXn3Vlli1NF7L00oGVKsF0rQvxblqJ7CY63ewFHQ1CEzHwLT4OvS12mRceSHd/+0
	 p3Cs1wAf2jmAmlWSGnB/3hfB3+4dos/MIygFf6DCDU3nZoY36ADB/AFnCj5HyDii1g
	 dfyyd4aL+yDATh1I3epjU3Tl1ua+JVTbSpNYDudSTnY87gkU3pUrifqd3ghNyFKXoL
	 hLk72Io5evs+O+MFEFIGnEOY10xbTdOIW4ZQd7xcxBvRVyqcFwE8YoWLP4U2STaqEu
	 yyTutBzoBzayWoUgQeQDyFvi06nUd5BvMxeMvFCrIp1JjuEfJbII4f0S3rkRqcPqgF
	 I9uJLdnNamEQA==
Date: Wed, 8 May 2024 15:06:52 +0200
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
Subject: Re: [PATCH v2 21/27] rcu: Rename struct rcu_data .exp_dynticks_snap
 into .exp_watching_snap
Message-ID: <Zjt47C16xcFbs1X0@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-22-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-22-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:25AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the snapshot helpers are now prefix by
> "rcu_watching". Reflect that change into the storage variables for these
> snapshots.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
