Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14202DEA92;
	Tue,  8 Jul 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982865; cv=none; b=IV3g1Uk7rXwfv30pBjO1DKsCmuHo2RA+rDMKI9J0bjbhSxRKt75Z8nLoNyXZlMZvQLPwyDLNNFm+s3rVh/Qp0umnbHeZBHZl2+A3F1VFgTNcy+wXmS42xhNCLSjRCJKJOzUsxI+LtK92ehNo/kD8J5q/RKImE4EP2iOa9vhiPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982865; c=relaxed/simple;
	bh=tfXtUJYz17eZYGV5TLj5X8FYA3fgxFhDxCkcMtg2T2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeozKUUaY6tgAeJYi/L14ZTa5cCacIjyiaiudG+ysPwQlvJf5jEsQhCqZ+gVO+PS/VaJWluN/lOACN/6yEP2Xz5JAwu42vBosa7FjWUNITjkaR4LlctIZK8iBdOA6a2kn73yZXy24rdpw3ocdbTvobUkhqodsv7GObt+GnYGFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzH0za+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzH0za+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC36C4CEED;
	Tue,  8 Jul 2025 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751982865;
	bh=tfXtUJYz17eZYGV5TLj5X8FYA3fgxFhDxCkcMtg2T2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzH0za+1547pYp5aFtE3zCWkdztB6nPSMarSqvJU2jCqsCGZtcHPmMH8MHYyOHqNn
	 DcEFbE1tPKwBP8Rv6JUEGfMyFwLWT28SAZOCcmgkVxCXQRWQsFgFtWQ6p+sCtkcSgm
	 dCz2Aw/N1MrbiFdt05kAqpXy+FKaYhKTkVztT6sZ5x/2PWJIqJbBKl4IiBP6cDEuqX
	 v/ZG35Xb7zVL7L115p4CZ6mlv0LdHdx0GfGpitwe0VuNctGHrJka7+uQ7fLY+Jnqp1
	 UB4GgjQ0Jeuxi4BRr6y0513XfwXjd45oD+R+I2NiumuZtXWk/gANeJ9y1MgxEEMPQ/
	 Znw4+Vo1KrNeA==
Date: Tue, 8 Jul 2025 15:54:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
Message-ID: <aG0jDkBqPGm9-Wia@localhost.localdomain>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507112605.20910-3-qiang.zhang1211@gmail.com>

Le Wed, May 07, 2025 at 07:26:05PM +0800, Zqiang a écrit :
> In the preparation stage of CPU online, if the corresponding
> the rdp's->nocb_cb_kthread does not exist, will be created,
> there is a situation where the rdp's rcuop kthreads creation fails,
> and then de-offload this CPU's rdp, does not assign this CPU's
> rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> rdp's->rdp_gp->nocb_gp_kthread is still valid.
> 
> This will cause the subsequent re-offload operation of this offline
> CPU, which will pass the conditional check and the kthread_unpark()
> will access invalid rdp's->nocb_cb_kthread pointer.
> 
> This commit therefore use rdp's->nocb_gp_kthread instead of
> rdp_gp's->nocb_gp_kthread for safety check.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
