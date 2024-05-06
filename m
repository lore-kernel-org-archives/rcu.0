Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4373757EA;
	Mon,  6 May 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992211; cv=none; b=Kt2nq0EQAW2wT0THS2rqfYr+JTZIaSXUa5isQxU2IUyYG3OhAkduYDoBAOxVGp74xeg9GE/L6ChMtVbtY6DAOXoGJNjgrdGyKD5bdkssjJrFu6LVkmRpdDipBIA2Eyx4DZoOe1iE+OhQZCA33KRwVIf/MLdGFfWcokjhuelMfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992211; c=relaxed/simple;
	bh=ZGHB5uq9Zx9MfYbly3aJE6/2v+I/OPZ2Ml9eJknJ1ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHm8/Sy3IuTrMFLnt8VmtmkuOhpIrDNkcsvDk7XZHQjLXB3Eck7W++9J7WrW+wbtmE+DJ2Mv+YHTLeYvgvHmxvzhWm+DXTYMJ6IemAM14PCCZpymLwsPwy6n5ThcTimgQMkdV2HTb/sWkrpDBm59koh+BvSjsrXYkwSXAoTI0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0tY8XLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0tY8XLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55854C4AF18;
	Mon,  6 May 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992210;
	bh=ZGHB5uq9Zx9MfYbly3aJE6/2v+I/OPZ2Ml9eJknJ1ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0tY8XLD/I4YCxr0hur+KJHqC14EtXtX8r61eWwgSis03TUZu+QVFhx0m0jvBNVqW
	 3dg8QoXHAP41bw5cxLMMYFTqFYzMqEoK2uogU2Jv/OD7IVAhGbLDjCqlw9jIFdK34J
	 thps0jzxsQNn335K5a4IOY1wBRuA2+1Kx8f627cb33xOoXBxH0maLNLndsEph+I9Df
	 auhyvgWVWKWxtKcRFUUTaEyoDY3GpvOZxP2NSE/5X86AVgPOSgeoPigvLVwOAKq9O6
	 CTflTahYtidTgsCYTCiIK5fFKD5xHEouBB6hCUPoy7qtYdbXGupa1SnqSWWAwnHiem
	 6MtLDBdTkPefA==
Date: Mon, 6 May 2024 12:43:28 +0200
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
Subject: Re: [PATCH v2 04/27] context_tracking, rcu: Rename ct_dynticks_cpu()
 into ct_rcu_watching_cpu()
Message-ID: <Zji0UG92wazXJIey@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-5-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:08AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
