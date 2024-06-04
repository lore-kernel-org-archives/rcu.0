Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C128DC7;
	Tue,  4 Jun 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540587; cv=none; b=B1IXZmxZwWlU6VQVkWsZ8Svt+cUUAuk3UY6LpeNrUiKKOMApfRbp8qzjeQPgb8gurPkLqckveqs/uKwzuruVGzJ8wTNlhbZ6uhuYxTSex860juew1U0GKgNm3EA/VvYdlIzpUxIJKfgOz+6JPQPPU/DS7RQBoK+i0L4xQDTjtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540587; c=relaxed/simple;
	bh=9Bn48OKZlqwf9LNsqYGIsbAU20Y/V6Nb+Uy1v4Lwyu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X2DyNdPxZfE/x2fy4mts5FexE1lY4wSov/j9ypA7VeDJuFsJcJ71kv+9DOtaeZsmdrXKRxAg5Aq6vQo8PsDGve3z5la1YGBxRs9HfoTywtIWYJZh8zQhnfXoXiO9qb8Vmnw//HwtG/FBzdjJsJIhPWIXL5NOW7vWjA2M9xpEfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQc/+Ogn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQc/+Ogn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F51C3277B;
	Tue,  4 Jun 2024 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540587;
	bh=9Bn48OKZlqwf9LNsqYGIsbAU20Y/V6Nb+Uy1v4Lwyu4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=hQc/+OgnRppaSrW5W812wwHZeuoXW9jtyj762VxpsEMKJWDTi+Jsc0iTesSZ5psJw
	 srCxSNFMVaASZ4PAMTVukhdH51EVN9j8XzQ8ZcMj89hXfSek8epAiAhQ8yk/KmxgUR
	 iWwgxn8fKFq6KJW79EZ69xDu+oNYvIL4RK9HN3hSy2TYAEln4P6hSl17G+IpzC9l0e
	 CfAPX/BC5I6emxSM26iFFHXxRasuPBT26+Yut4fDZVHVWHVtipeD2ok/Cp4x6LIyAd
	 OlqfdQX5iB+BSA7QvzKqZ4kQdxLbyBrBzBGkXV+HGVgDHQ+kDvGGn78D+rSZHAdMZa
	 xDjQh9UUIqWhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00DBECE3ED6; Tue,  4 Jun 2024 15:36:26 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:36:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Torture-test updates for v6.11
Message-ID: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains RCU torture-test updates:

1.	Make rcutorture support srcu double call test, courtesy of Zqiang.

2.	Fix rcu_torture_fwd_cb_cr() data race.

3.	Add missing MODULE_DESCRIPTION() macros, courtesy of Jeff Johnson.

4.	Add rcu-updaters.sh script.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcuscale.c     |    1 
 b/kernel/rcu/rcutorture.c   |   46 ++++++++++++++++++++++----------------
 b/kernel/rcu/refscale.c     |    1 
 b/tools/rcu/rcu-updaters.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/rcutorture.c     |    3 +-
 5 files changed, 82 insertions(+), 21 deletions(-)
