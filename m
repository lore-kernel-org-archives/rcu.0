Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E533EAE6;
	Mon,  4 May 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928746; cv=none; b=Gyn1aDyHF8gdExXwlm4LYbs7fPJpelDrSTwdZorau1vN/0ei3GM2dZ/dCxOGQg6s8byJmFverAZROJYNdC5l4jlOWNOGUoFusmRKWH+9Vn991+30VfhmTWRsix4ek8FX7RQwlMRirJFjFuj0aKqxI890agQzMQsdp0CPmsZBTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928746; c=relaxed/simple;
	bh=lszNji3gfB4OV+zUwqOce+JBqoIW8y8p4WzQNyPKTWQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cxrPVy7lHQCgzmtOOLHg3nfNIsAhATQ2AzKe66srfsD33hmDEhiG0DgbJwgRoNsTOakJcTh1g4kSG79UZX3laPrNV6rxXHiECIaIz5IxXcbNdqhCkq3S1gJI0iAmPcA/LQ90Dt0oFuoO98gepY5hgJA2uwFmwq1r/9NuG4Hkz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCP33M8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCP33M8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9820C2BCB8;
	Mon,  4 May 2026 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777928745;
	bh=lszNji3gfB4OV+zUwqOce+JBqoIW8y8p4WzQNyPKTWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCP33M8h4HbqrfRyMeuD0O+EtBc6VFM8/waltI7hmW7ux/WmzF0sEnYW6LBvx9Hev
	 QrQoA7KHo66/E/FQWcm2bCE3ESTa1XggVkXGspTfRQ2xxRBRTC6Ll5ELu3DHgUA1of
	 AzGn4pjK2lhlf9SxPcyzT7/SMb6gZvY3yYyULOJkh7CMDahPGtpJXpl2pRKjMnDdL0
	 VY/tesZFKOksLBStcN7KD/k4OIuBI1DawFxHco+Q2rSjAsVvRowNN1liBtiZpli1ui
	 bq+ges8QV0fAJSvNfO3g+0Ygq5DLc39fiJ82P+UfqnTEy6VvZEs+sHdgQ5kG6uZXBC
	 3LRz8r1DIyagw==
Date: Mon, 04 May 2026 11:05:45 -1000
Message-ID: <08bea85cdc8448c923f7d141863177f6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 rcu@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
In-Reply-To: <20260504161543.674488-1-yphbchou0911@gmail.com>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Hello,

Applied 1/2 to sched_ext/for-7.2. Holding 2/2 to give the RCU side
time to weigh in on the smp_processor_id() / raw_smp_processor_id()
change in synchronize_rcu_expedited_wait().

Thanks.

--
tejun
