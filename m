Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071F7080D;
	Wed, 24 Jun 2026 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339594; cv=none; b=Z9EhrS+ybJDmXHC6XLBadd7Fv1+c+OqhBddCWd6CzpfwOTpgPNQfOR2DQHgStGclReJWXThObfppJPxk8YczImVcjIuZUrEK5ONl56NoTnGSJ5BEXLHkSBMO+ws/XF1sHaI05wGo/A0eXWdLKP4HwACg81M7EmqP3F1RP/s6tLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339594; c=relaxed/simple;
	bh=5oUnmmw0PTX5Nre/NiQpgtAGlz5KlTEA70DZzdVyOW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhev0GsJz7dIFyegJlH9p9hvzJRwyS/qgRwdOVulBLlABfcTU+Hv3vL3MsF+1iIYtFy3FfVotM0kMz717P/+aeIEqJQ+Y+sEdah27ZQtppsHw6TA2R+0qf+x/b+T+QqaajhXKSuAI5XNgm16MM4l/qp1fjuLqLjVuBBH726trh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX4OoxPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX4OoxPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0301F000E9;
	Wed, 24 Jun 2026 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339593;
	bh=aFAlgWxX9NVau2wUwqrSrRJ9yxhGBTuMw4mflTGLXTI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lX4OoxPsE8vO23akhuRcg5BncD7UW0oZCW37HMIcOB95RQislHtHau/zyec55QdUA
	 J8jU3hM6Mr18bum4jhe/eMEU0ODXM8eNvNQ6jFAnVE0MMtdcPiA/ztvhd6iq1z/DKk
	 Bk0OqiKW278bhPuRJRijgOxm9E0zEwD3ao1HVJDujtcMfRq/3PzAygKVGFzPYkQwlk
	 VnJpnkIibRL5enWlWrKxIDaEgdd4/KqMLZ7FZtOZblHm+DMgqKs3VYuM1OcmgWPoS0
	 EDdKCkV0QJlF/ftSF6r7L0tuDiXR4NYBh05CZjGYDxJVLFuPsWBqzrpYWVRXV5q6cB
	 q5pw/bJx4rbsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 516BFCE04B1; Wed, 24 Jun 2026 15:19:53 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:19:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	rcu@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH v7 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for
 exit_cpu accuracy
Message-ID: <f07250cc-4d47-40bb-be9d-0af876a122b5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260610152717.15905-1-yphbchou0911@gmail.com>
 <35bb42996fc8554cc73a0496eec36614@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bb42996fc8554cc73a0496eec36614@kernel.org>

On Wed, Jun 24, 2026 at 12:04:33PM -1000, Tejun Heo wrote:
> Hello,
> 
> Applied to sched_ext/for-7.3.
> 
> Paul, I'm taking this through sched_ext. Holler if you have any
> objections.

No objections, works for me!  ;-)

							Thanx, Paul
