Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B312880D;
	Thu,  4 Apr 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237458; cv=none; b=h+yxTw2G7ZDI1nmSunM849C32ObsWyPqrdVbkhB5CaNa4RSjqm4U3URETmbOGAsD/626498i8imH8NHypAC+euJqJC+LFfLwgdR639G0W8psz0C9BYtFRaBkzD7cqOA9+uhuJHxOsbODUddwrZvBMYTxzWfVeJ3H6z6dxdI7d1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237458; c=relaxed/simple;
	bh=P0u7JqtUYYv4T9lEF1Dil+ZwXkCzciUi55skMYTvhYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaKRfnf4+w8CdQ7zgHKplXw4DKsux+lCovbRuwEFBvt2wbQmlILExwfhUeZjOk/ajh/F0d1FlI3dpOWmnqIXecdePHY/JZGWgsBG0pwwsR40G1q99Y5Jt0PDJ+nHrAcvimN4txI2qnuU82N39MqDI1Gt8UGcSfdFc34yga9D+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSepLqqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSepLqqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA6EC433F1;
	Thu,  4 Apr 2024 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712237457;
	bh=P0u7JqtUYYv4T9lEF1Dil+ZwXkCzciUi55skMYTvhYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSepLqqvEcna025mOzzoc069P+lFQw1Njofu1jZzwweyqS70133BXls3GOEnE52S5
	 hNgYqC6U0SwT4HQLg/R43h9rUIyRK+DK24qVhP0TBSHhv7agVYWaxlUHABSm4q4VLs
	 iCd5JPy4h8iMb4dPcCL7cTXSgG7Th4BZJI6ZGbbOcarYdttiAKAqI5kUSVJuvoO4G/
	 qyYGXgumr864ygSG76xHl65Zr/T8uvDONjndE669yaaDwnithlTXkgQCny7yccUMWl
	 Jvc4Dn2/c3edOyHukxY3zys8hztXFXC0jCg6xzdYmRI9qLe6uwt0zVyJPjWE3h2t3s
	 lSWovMDDlYBXw==
Date: Thu, 4 Apr 2024 15:30:54 +0200
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
Subject: Re: [PATCH 1/2] treewide: context_tracking: Rename CONTEXT_FOO to
 CT_STATE_FOO
Message-ID: <Zg6rjqvHZZGw0Z4y@localhost.localdomain>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327112902.1184822-2-vschneid@redhat.com>

Le Wed, Mar 27, 2024 at 12:29:01PM +0100, Valentin Schneider a écrit :
> Context tracking state related symbols currently use a mix of the
> CONTEXT_ (e.g. CONTEXT_KERNEL) and CT_SATE_ (e.g. CT_STATE_MASK) prefixes.
> 
> Clean up the naming and make the ctx_state enum use the CT_STATE_ prefix.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>
