Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9233E493;
	Tue, 19 Mar 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824337; cv=none; b=TVyssZBGlCOTTFLkkMX7J/nROy5uvbAE5o1cYx75xc0EVnDpRitupxaDB1Q6rNcFMr49QVtdXDZ0ANWqYgIkqwWyJiYH8bdOIVihMHoCy07yU4vSZG9EQwBOPMtljbumU25999wwbWQw8Dtjm9aMFymwnLw5cnIGKnziHbJbrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824337; c=relaxed/simple;
	bh=D3Sk8iLwmfVHRnRG12CefEPvS/8y1xU2WhjcEQ7NYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+SPgeWj1B/rgG61hbQO/GfnJ3LngyXdRhULIqlb31SXL7uJWPNNdwk/bTqC+HgEmliIJWwsMpGm68KGaxVNXeMV1J3MgrumUV+5J9yujX8PGyu7zL8dCKyxYkQIuA2E4I9qq+v3BVDNIJ3p+amYuFrJrNGJlXOuFszdRU3Ek34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+hcyMb/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+hcyMb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CB8C433C7;
	Tue, 19 Mar 2024 04:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710824336;
	bh=D3Sk8iLwmfVHRnRG12CefEPvS/8y1xU2WhjcEQ7NYBM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u+hcyMb/Dsy5MqlVU80IW4/AdTorDf1bqRL4oVue3luGhgOBQlQwA33SjjXL5R2oF
	 zGGIB4KP7Bu2mfH+pDdyjU5d7VtqmlfILjNTG7ImUhc1raczc9uNp9w4zR8yfgwPiX
	 WiWL0lpcB13NE7KvCnlbhV4aDFmVKU0W7wILf2sp958g7TLyubFnG6pNZCSiAnflPc
	 sqpaTeEa7cfvpQ0CVbGlK/87zwu9LLbvT103oqAYB6Un7wJZTihCcI3mDnb5a6aPkr
	 +WeqKjO1HZoEmCK5UbZp6GRgJu8n06BAt3tuuEROTCff905MiyVVSNWOcVDhynEJpU
	 SoB0WqjpcpeWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6AD9CE0D83; Mon, 18 Mar 2024 21:58:53 -0700 (PDT)
Date: Mon, 18 Mar 2024 21:58:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Generate get_gp_data method to print gp status of
 different types of rcutorture tests
Message-ID: <0071dd1c-310f-43c3-bb0b-694d0cbe0ed8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318093412.17258-1-qiang.zhang1211@gmail.com>

On Mon, Mar 18, 2024 at 05:34:10PM +0800, Zqiang wrote:
> This commit is mainly to enable rcutorture testing to support print
> rcu-tasks related gp state, and remove redundant function pointer
> initialization in rcu_torture_ops structure's objects.
> 
> Zqiang (2):
>   rcutorture: Make rcutorture support print rcu-tasks gp state
>   rcutorture: Removing redundant function pointer initialization

Queued for v6.10, thank you!

							Thanx, Paul

>  kernel/rcu/rcu.h        | 20 ++++++++++----------
>  kernel/rcu/rcutorture.c | 38 ++++++++++++++++++--------------------
>  kernel/rcu/srcutree.c   |  5 +----
>  kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
>  kernel/rcu/tree.c       | 13 +++----------
>  5 files changed, 53 insertions(+), 44 deletions(-)
> 
> -- 
> 2.17.1
> 
