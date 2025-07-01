Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E231B95B
	for <rcu@vger.kernel.org>; Tue,  1 Jul 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393462; cv=none; b=WVu8zHj9YUF15L7Fq0LOqVwuLn2W42j1RKfmlSn4GIHl5tDWZfGZXbFXbLBYqT0kB4PB7Xri/kd8f0UlraCPjaGkzF2liOdwtcF07sZCO9wfcFndAXvRMK7q5hZIg1I5KGOhUlGKNE2O9N0ZJEfphB4gjYOyQTvumWJ2fTbxGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393462; c=relaxed/simple;
	bh=xOmIIWG4l5jG+R1ZYGbdNpX4b2D/lwOdyUFNAubqfbU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f8W/B/dedCDk7QYaBoel3DNw4UTif/vUshpRCMyNwAf/l/XH0NDrm0ToBsSB/XOUg11pPWR/5vPzEXXbuTyXXanSf/yHX3pYNLMqviAKVneRASMdZdYsyMgF259bdFIJGIF2M8rqnEB43VsMFHMuFjGaKg6/t5f3FQMNBk25cNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrGqr/yc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrGqr/yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BBCC4CEEB
	for <rcu@vger.kernel.org>; Tue,  1 Jul 2025 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751393462;
	bh=xOmIIWG4l5jG+R1ZYGbdNpX4b2D/lwOdyUFNAubqfbU=;
	h=Date:From:To:Subject:Reply-To:From;
	b=BrGqr/ycO7oKC3yzsXseRGeuJlJb3oID1DECQrL5xT77RB18DsJzwX+kVjeQoZT1N
	 Sf4zEERP5cMo3kMQRWUdqYl7/5sU/xJXaRRyr+5nXj3Enzrso80zHdkmerf/sc0F2e
	 tAmiqQo7qSCVAniO+q9P1gKg1vx4HYy/IvELA8VZxWlwLWPfDfIhKLUfqcRfFRzZ93
	 cC2ZaToe0QfgRQT2u1+67x5oQ/wE87/Duf9XAvDP9kxW4KidO3mhwfAx3OVOrhi69c
	 UJe0bwF/T4A/tc4wQD4rZMCWekVDscQzSPMbWwtR7REZqHvIjzCaBs/KUnf1WB0BSv
	 Z5cRj6f5iF+Gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16FA4CE0B05; Tue,  1 Jul 2025 11:11:02 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:11:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Subject: Fw: Statement
Message-ID: <7dab50cf-ec63-476a-85fa-6aa18995ad7c@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

They do seem to be getting better at getting through spam filters,
don't they?  :-(

							Thanx, Paul

----- Forwarded message from Carline Hood <zaqergrd@gmail.com> -----

Date: Tue, 1 Jul 2025 13:55:54 -0400
From: Carline Hood <zaqergrd@gmail.com>
To: rcu@vger.kernel.org
Subject: Statement

Hey there!

We have received and are now processing the latest order you placed.
We take delight in making sure you're satisfied and appreciate your
faith in our abilities.  Please contact us at any stage if you have
any questions or concerns.


Carline Hood



----- End forwarded message -----
