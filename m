Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71B82490;
	Fri, 16 Aug 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789494; cv=none; b=E6EJ94ZmSIdlFvnM3FJ+iHDMBhIwj2lM0zvcGyssfPal/PUJBdUZhLYXJ7ZjJlxfc6BwtNBlaBVEs/SghU6D55TPIthAczmVz4an/Wc8pWbPhXbNE6K5Y+YVMvauhOvqKeMBbZWO7vXMb+LgtBs5DqDFeTpMQOo3uUKr/HcL/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789494; c=relaxed/simple;
	bh=BR0GEJervlQ+7aD7xIs3wcqErDpphfUJrKHQMs393EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ckY50eh30G/rqK9+wL4Sqg8L98kjpwnxtrvB6S6pg/PLI9DQq8XX8EaoF1fu/FE2oNQMSsLro2tfPH1ZCIA3tt1+pbS42FFyBq/jozB3U2K8YEGuzaEtrsnxlV8eI6XG1BCrPJ0ADtUw5Feji8AlQZsOKU4DmoFtNEzc+zMkX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byNE3bGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byNE3bGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BFC32782;
	Fri, 16 Aug 2024 06:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723789494;
	bh=BR0GEJervlQ+7aD7xIs3wcqErDpphfUJrKHQMs393EQ=;
	h=Date:From:To:Cc:Subject:From;
	b=byNE3bGSUI4qLZRKbLjnpbhUZ9j2q3NVC5cphcj2qMTv1L4dpinaqk5WitzRpnP6F
	 a7jf5ZNVbCzORcgxEfz/fMDtxloKzPEX3kdiv/+34ENiA6rLly2cgtKnQWxuKxEYTx
	 HFR7iujtm7sjFEa5a6ZHz/uNAELFXd8E0S79LuCAmKQoEE6irQF6HFZod9lnAnlxIR
	 qZrVvcUdDOaNRsFZQ8Hwk+Sen5Fn0rgBZEQcsqI3QYoL+KOqVIq89lP5eNlcpvVNjf
	 tGAwXQumVrrZOicpXGiRIkkvIvE5tbNS2fpIjdx5bd4RSBmU4red26pEjcIJukgFTK
	 d8axi4zDkfMQQ==
Date: Fri, 16 Aug 2024 11:54:45 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, inwardvessel@gmail.com
Subject: [PATCH rcu 0/3] SRCU updates for v6.12
Message-ID: <20240816062445.GA51253@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Following are the SRCU updates for v6.12:

1.      Faster gp seq wrap-around, courtesy of JP Kobryn.

2.      Check for concurrent updates of heuristics, courtesy of
        Paul E. McKenney.

3.      Mark callbacks not currently participating in barrier operation,
        courtesy of Paul E. McKenney.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=srcu.12.08.24a


- Neeraj

------------------------------------------------------------------------

 include/linux/rcupdate.h |  3 +++
 include/linux/srcutree.h | 15 ++++++++++++++-
 kernel/rcu/rcu.h         |  3 ---
 kernel/rcu/srcutree.c    | 11 ++++++++---
 4 files changed, 25 insertions(+), 7 deletions(-)
