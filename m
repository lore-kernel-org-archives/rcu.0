Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB23C17;
	Mon, 29 Dec 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035774; cv=none; b=fD+wZj4x/ARlEB4IYlEdFn6XeJPC22dwTpp2iO4YFixS7RtuBB4KugIIUQ9VUXiND/vQOJjq7FWsgXABHYmn9q3bVbhIiELhn9AhSFUe33uBYtrHthWzb1J4rgnuv/KXYSdx1YTAvAOnnO/R6HPkbfpENzi7ag2rQsVEy7BvWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035774; c=relaxed/simple;
	bh=7IT9cQkyUyfQY/rb4ZlzobvRDIJIpvyb5gmGp08jRXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OnPuUxBzaFzqGUptwbcm0qewH5RsPAEAuXbLP/xPv3tP3Cmv+aBS2PrqASjtY9HQ9KssUcVEnIvzsvMQoR22IwJkmD6AR/IpEXPwsaFpRl6Wtfcfd04VmO97281dKKV5mWtJQSFctmM+Vwoyug1jcAmNmBSRbk9MvwMXnGuLiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f60xR7OQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f60xR7OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9B3C4CEF7;
	Mon, 29 Dec 2025 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035774;
	bh=7IT9cQkyUyfQY/rb4ZlzobvRDIJIpvyb5gmGp08jRXM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=f60xR7OQpuIiR1ain4ZZIB7clOoSUlE8OFBRNbRmQFCfT/N9GVX71ANtgC6uoGumP
	 /XA+t4mJFNXXv/1rNP5GyRA1ouJjm+FX52n48koWg+yw4oOaDsuqEB0HXGtpQvPO3q
	 M+Oh8VwGpNGhQlAEZMDBDKz/mGcMKyPTS5KnQorPYFBVqvVhz77xpVzlbQbi6S/EkD
	 4hxG9c3wtM3glw4GiLyNEo5e8sgtKNjM9BUH/uokotfsFlnFAFE0rehkn9a0IHXmnv
	 ph7nq0aqx3zuJ9b+u6nbFI/r9jWztWdlpkn6HU1X7hVscnjYmhgBIWk+VKO7YN89UX
	 sFsdn2qRn532A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7720CE0C97; Mon, 29 Dec 2025 11:16:13 -0800 (PST)
Date: Mon, 29 Dec 2025 11:16:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/2] Miscellaneous fixes for post-v4.19
Message-ID: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
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

This series contains miscellaneous fixes:

1.	Make expedited RCU CPU stall warnings detect stall-end races.

2.	Correctly compute probability to invoke ->exp_current().

						Thanx, Paul

------------------------------------------------------------------------

 rcutorture.c |    4 ++--
 tree_exp.h   |    7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)
