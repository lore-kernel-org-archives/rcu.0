Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576E35771F;
	Thu,  6 Nov 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445530; cv=none; b=kV+fcfKamTQ5wfsy9D8YA/w4WJqe+qIfvNVyV0zTFEuEuDNaaV11MNaNGi/dqZJe2fcJWBkjBIKNDETAZpgy0leAuIB+wO8/qvTmjp1OVq0mjx4tfYNDGaLIrP8M8ohSdk5j9bY1elhkymwh42Mt0e12z3zmncxNpJRSvXCBmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445530; c=relaxed/simple;
	bh=M2KCArV3HvYwfX337pg6kX1OdzBZi+Y56Dkt4B+xpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoWb2yEDWFl79sZITYXd0PMcxjT2PW3tM9pssTi1O5oFydkmQvQJgYsnn3C0tFSYdPiA6u5vRVHirHtxgLM4VhlzSXQB+etPJctyOk8tTl8FTHPdOFl1LkvKxsU68oLE7NtxDPBt3TiJjr+4vMxBGb2+uJwnsIJxivUR7viQ4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 99A3012B846;
	Thu,  6 Nov 2025 16:06:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id EE09F20031;
	Thu,  6 Nov 2025 16:06:11 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:06:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/16] SRCU updates for v6.19
Message-ID: <20251106110610.44599177@batman.local.home>
In-Reply-To: <aQvXA3A5XHn-Tjhh@pavilion.home>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<aQvXA3A5XHn-Tjhh@pavilion.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z5axpn7mxewozj3399h19brbjbym3jdk
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EE09F20031
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gKla3s1j1a1wwuMYU5lmINDisNJWHUHY=
X-HE-Tag: 1762445171-146636
X-HE-Meta: U2FsdGVkX18ZJE5NlgpXfPEuEqsP3Yu3n3Ldvm6ld2CCOrA9ditZj4Jr0sQs9TknEUWrYBLriAdHyyy83mN9zO7fLZcww7RgOjnKhQw69BYx3bTWHLmnSGObStRW4ht46Ni9NUY5z715YaKh4HK9y5N/LJecexfUVR0P//T11bJyzgqZQPQN4vn9P7BTk+cDu+GEgTl+FPtEP78lTvAyFSaPhrmxIByA11SxjNyVADH4Bps5MpsbtmTm/fA28GDXYgqzgNseaeR6YQYqxe6pp2yWPJVEt3sl9VxGSzvFSDlV0Iq0D+LlSdPJbPgD7QrU/uHxxNm3fKKhsPEiW6CprDuKhqYB6jWLWegoxaity6NQgYcsKZzrIw==

On Thu, 6 Nov 2025 00:00:19 +0100
Frederic Weisbecker <frederic@kernel.org> wrote:

> Applied to rcu/srcu, thanks!

I have issues with patch 10, so please do not apply it.

-- Steve
