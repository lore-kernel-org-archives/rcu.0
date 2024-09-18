Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED817C7D9;
	Wed, 18 Sep 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647008; cv=none; b=R6SDHEOperxrrSLX/r6lt91DIVe5DNMsjDrf+6rVL1wFjYuc3F7tXcCyx5EcFIvonKXjqXbbO/v87LWulCqL57Wej8/JIGi740llSL5h67yZCNKKFkbANlZCdmPsE7Vx324Vm+GJPjtjZ2dVT3GLL3KFRfkqdjdiu124ZQI5bNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647008; c=relaxed/simple;
	bh=Qsb5CkCGLTMxWStZJMNS0jJ8FSHdnvzp+nam8PsSjT8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hA2B27gtYcqB6PL10mO4fUU3pTiyXQ4CgkL5GVX5rEOMAMLXqVLK6KIrAKpgAoNYyhtAM6HD0wzwncIcvGGWiqNXZlS1zuPe+p1bYB2VJjkiEcVDZjoQsqdWo0iZMkMoFNiwMG79jgKmiZzJFAYcqs+IQOl74UCt81fua4EuJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDeJAqEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDeJAqEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8CEC4CED2;
	Wed, 18 Sep 2024 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647008;
	bh=Qsb5CkCGLTMxWStZJMNS0jJ8FSHdnvzp+nam8PsSjT8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JDeJAqEu9+XTkMHKRvcvoTY85ByKeZbx0Ufwj/KlMpymq+ymUBUzAVhEb3JAfPH6l
	 aK2bTM3Q9oJo6nOIKX1oahJ/V8BoJ1vISJJepeqsFmKPlX6IsYunP93OBRfG3M1mju
	 e2fGJYab2Wyu34v6s0Kn39Y4QWkeALKbDteNV85H2oIi7f2i7Tx4H64Q07t9CBUj1z
	 /uVu5qYVO0C6dwtS6UjpaYrRKA65sPUL2SRuizybW26dzo+mqM7AJ4dGkxhKIHwHeo
	 kda8tL+aQyS0pbp0G1zhyDvhtKSuyBC4XO292hBB+eI+a9/taX0dK5gaaibUV3tKC8
	 fzvRv5YRIO6lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E9E533806657;
	Wed, 18 Sep 2024 08:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240914024527.GA492739@neeraj.linux>
References: <20240914024527.GA492739@neeraj.linux>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240914024527.GA492739@neeraj.linux>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.12
X-PR-Tracked-Commit-Id: 355debb83bf79853cde43579f88eed16adb1da29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 067610ebaaec53809794807842a2fcf5f1f5b9eb
Message-Id: <172664700971.684502.10200905341930966389.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:09 +0000
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: torvalds@linux-foundation.org, paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com, neeraj.iitr10@gmail.com, christophe.jaillet@wanadoo.fr, inwardvessel@gmail.com, riel@surriel.com, takakura@valinux.co.jp, seanjc@google.com, thorsten.blum@toblux.com, vschneid@redhat.com, longman@redhat.com, zhouzhouyi@gmail.com, qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 08:15:27 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/067610ebaaec53809794807842a2fcf5f1f5b9eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
