Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09E30B528;
	Fri, 16 Jan 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600569; cv=none; b=EE2lRiVC/GdL+gqvo/GBk9X3/opfGbQbqYDPYFG1ymFVmgme/Q5kazIn6LXPI0zx257vYYmF2X8Av1/MS2DBcrBcqFyfGfo0bWDMk3ELTshuHWlXcC+hp/ERxE7vPDJaOLkED9rS8GfTjukLUNPaK/+ENo/Sd7ADL5941OqbJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600569; c=relaxed/simple;
	bh=baHuV4XDQ4qytLBVtw2nfc4sXn4sl4nQwTF4CMczjyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M40Rcd9bAgCmUXWdWPXB52YHS+i0RCHd7rT1Ooj2f2rACwAhaUKG+EkBLkcznZk8yHWrqn6gN/l0045K6z7XoX9bXEHFsBnbyJaX+93jlI7mMsk1VrGXDMvG8zRLheeH/Lp0M6vD63qrfJ8gRKAV5L0OgCbIgdWaumgx8gKkDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0P1W73S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0P1W73S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D81C19425;
	Fri, 16 Jan 2026 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600569;
	bh=baHuV4XDQ4qytLBVtw2nfc4sXn4sl4nQwTF4CMczjyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0P1W73SVu5jdKSm+lnBSDL6xodZ0YLS0hBsoKLhDsLxBfJQ0Q1qxvFA9p2YrFx+0
	 DX76t8vJYpEa9NI8qmBgZ/AvNllfnglid8ml92BE7nlzphFpFp0WJCs2bhk33mlGQJ
	 6uuqS4+bngBDbPUPMUhYuG8Wo0i/vbD2d8Bn/3oGB8dlslyQfnbMkJ84DIxj4LU/rn
	 BIkhPQkyI5sGEr0YUlKPvJu1fNSxD9QhqbsmNHuVaX7HaVirnFzUqWPu5Sl0SB0dAB
	 lbiCkkcltAXj5fto7iZ75NzZ9L1G/V2pokTxx2NU/NwkByKV73gP2bnApz968KnfwH
	 p0efvYBttHJvQ==
Date: Fri, 16 Jan 2026 22:56:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v2 2/4] rcu/nocb: Add warning if no rcuog wake up
 attempt happened during overload
Message-ID: <aWqz9Wvrf5683OBQ@pavilion.home>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
 <20260114173154.1701056-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114173154.1701056-3-joelagnelf@nvidia.com>

Le Wed, Jan 14, 2026 at 12:31:52PM -0500, Joel Fernandes a écrit :
> @@ -1254,6 +1262,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			continue;
>  		}
>  		rcu_nocb_try_flush_bypass(rdp, jiffies);
> +		rdp->nocb_gp_handling = true;

It should be true already, right?

>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp);
>  		sc->nr_to_scan -= _count;

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
