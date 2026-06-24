Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0741DF751;
	Wed, 24 Jun 2026 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338675; cv=none; b=XFAgjMddE4BQz/TkIkUjgteJdyuAYshQyUmBFs2U5OEsylyGa7ZxBWvVfudD+QMafKV/vdat+BcREhPq66hWolvLwKCCo/waMZOzST5JlDvoL090aPNPrbhQ2yuus1gU21CwJu+8VpFGU+8taSH83Y0zAtYFppV9NDc08dzyB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338675; c=relaxed/simple;
	bh=ZI3jzB4WPqGGrXcDd/mn0WUeSz4Em9nFjFL5wiRYetY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=P17FjBrRT1aqFuB4S44H2/29cD1eJFV/WSSVr4P2C1Vz4hmI77D/K3LPSY6m8mVKfz0KCSfRywfP01cNsFxfwwEZbynjmHnN4vIXBfXtmlosF6eYcH+7IgBDiUGYXaQskYiiu/CA13oLEIxk/+Z1TQ/l6ZauNNj2kwaQU3UNvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSZDkXLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSZDkXLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0320A1F000E9;
	Wed, 24 Jun 2026 22:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782338674;
	bh=ZI3jzB4WPqGGrXcDd/mn0WUeSz4Em9nFjFL5wiRYetY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RSZDkXLe7E07z/hDjuzIOdZtOkTFgXX+W7eYYBAaG1bzBDxFwdf/yQhe6khDkZOOB
	 g4uNzL63ICu1x4gzlZ9kEvopzmBD0QOKSddgkFjAShmpYiLky30Huu5HLZFb4NLOBZ
	 Ih5kWgb417YJLWx6EPUl2uKuoLO6ua9VYmsxFyeQssLoQy5Z0RSif14JD7kjIj38cK
	 BwZ1apFuwzkhJpVpWYimuswNnGDPD/3hDzoPKRHfrrIKB9SSVKymxCWR8fKNxJOu/W
	 v8x/Oly9uCDwW1Cdvs0GHApCNjq35KW+KlmVV5Zoay6Jr3gFpkwrLGf6kZRPqyZOof
	 aY5OOMlyf6aPg==
Date: Wed, 24 Jun 2026 12:04:33 -1000
Message-ID: <35bb42996fc8554cc73a0496eec36614@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev,
	rcu@vger.kernel.org,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com
Subject: Re: [PATCH v7 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
In-Reply-To: <20260610152717.15905-1-yphbchou0911@gmail.com>
References: <20260610152717.15905-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Hello,

Applied to sched_ext/for-7.3.

Paul, I'm taking this through sched_ext. Holler if you have any
objections.

Thanks.

--
tejun
