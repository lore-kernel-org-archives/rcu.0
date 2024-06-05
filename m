Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017E1922E0;
	Wed,  5 Jun 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587738; cv=none; b=FEW9ABQCPVRr7UyGMbCixHO0FpUF8ES3pF/68cNz2W2kkg6HCoWEmsb2ZotNkKOZG7wbXz6ONmVSvaDRpYTuHIt698q9G8FldyZ++ppx/0VaBYs0RdV/IwzfLEIC2LKuAu32/ayqA5UJ03YG0sQDA3902ttkswtd6XVcVvx5KU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587738; c=relaxed/simple;
	bh=/+ns6Sioj6d4ZKKRmDu/3wsP7X0hLThY8uABuPywhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBGR4p3DkUCt/09MiBRuCt5ZeF0/q7wn6CwCIzt0sllruyc85VZ7LmSEn2bxILU2AJMLbp1+emQGJv4ujZKdUw4uFyjNWRNMxLnQ1i+ZdlQhTOg0ll0xohjwl+xVOhf9USckgVYxsN7wFBmE2Bk/CCZe6tBl0BgTOeAS5VCBcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwaVkB/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwaVkB/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8F4C3277B;
	Wed,  5 Jun 2024 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587738;
	bh=/+ns6Sioj6d4ZKKRmDu/3wsP7X0hLThY8uABuPywhqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwaVkB/QV0sfslrUNSauMvygURi9SxO5NHd1vfQpMk40EuQ9rVOvDOsOSQhH1YGb8
	 69tP+fWhzyDrNN5npoYh8WQ5g0IQnbkpXKXRNb9Xo1hY1drF4KSyik21mHDtzsO9aO
	 Y+R4j2PjMjyfcO2hZhOzddzqGEWnsz6OujUawEEqypnZz5WRrWAvh7Oqdfrl5p01II
	 pNQYMozYul90QnwMwM7qFJBxvQl/UddnoDK+/tuFjaTNAerMXIomlNt9zAnyi/AiV3
	 IWVw2HaJdA/qZzpY6Spu7DJ9pbW6lmDPzpQwO9+80wI4xoO60ldQ67E7YWfQTBzVy1
	 tH1EIsX/gKxmw==
Date: Wed, 5 Jun 2024 13:42:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rcu 1/2] doc: Update Tasks RCU and Tasks Rude RCU
 description in Requirements.rst
Message-ID: <ZmBPF-a-qPk_bLbG@localhost.localdomain>
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
 <20240604222155.2370541-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604222155.2370541-1-paulmck@kernel.org>

Le Tue, Jun 04, 2024 at 03:21:54PM -0700, Paul E. McKenney a écrit :
> This commit adds more detail to the Tasks RCU and Tasks Rude RCU
> descriptions in Requirements.rst.  While in the area, add Tasks Trace
> RCU to the Tasks-RCU table of contents.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
