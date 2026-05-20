Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F539BFFA;
	Wed, 20 May 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281057; cv=none; b=meOZoWAHmXriNqoqsOEFDK5ZlFd0Qqje6ZaAQg+jQ+1ANEtDiVZ3VR7/gLfL/G+5Jdi/y+Kwf5W2zfQrf9PilsKdwe63rBFgEZbhZA0+UZrTFETfRJ1ZDKJiDKk4bnM/vEnjuKXuou4uJDdw4M6VLYfcBR9PMWtFGoA5hI/B9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281057; c=relaxed/simple;
	bh=+kTOjZC0gp+g5VfCnLkENOIjY7bA/qQ424j21ftQ2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0GJ2O0xb/9sNo9Z4eT4rWS3xSLWib7Ia9rFOhPrs+PsGOzRZiWxcZGxKEpUcNNmdyfKQnC/srPI3FWBBFeLpHyYJYAraxz7hF38S+OAgGGHuFIH0cPVkRZcofDmcg1BqLvwZsAQBAfiS+1K3pzSeJe2r2FywWY9JgCCn4hSSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9axrC5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9axrC5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE001F000E9;
	Wed, 20 May 2026 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281056;
	bh=O0rjzqxH4cdSRdV3o6+PTvPWEf2GVUBaKwplaQhNPxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9axrC5StWft7I/dg4HJUoPVVMOLnTbJ2cidxIhH4N9VNyHenyakaMF6QSqdFe7Eq
	 ogqyPoUF+BAzif9pBBfggmuPvK/P9IdWonxnABUQAISfGqzE791IrtoR1QcSKvrKcd
	 PzofweTE4Q7E6KK9WpkHBliR6WT38z4hJS1DEpi3v0wRagGiJa1ekAgP1QUElaVBPC
	 AhLiv56nCoFdGLZHwG8T4XuAWqxwkP2Cr4LsBqkIms+M3chmUDyNuBHOham9VfXKgX
	 4AKTG3ZVTvl/iRAGuIzWdYqe0rQkqAYFusrs4PlEM6nYKd6/frr38kH7/qUYXz2Re/
	 ZRHHjiGdimygw==
Date: Wed, 20 May 2026 14:44:12 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: Re: [PATCH -next v2 09/11] rcu: Document rcu_access_pointer()
 feeding into cmpxchg()
Message-ID: <ag2snBQX1eXNeToz@localhost.localdomain>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-10-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519194524.158515-10-urezki@gmail.com>

Le Tue, May 19, 2026 at 09:45:22PM +0200, Uladzislau Rezki (Sony) a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit documents the rcu_access_pointer() use case for fetching the
> old value of an RCU-protected pointer within a lockless updater for use
> by an atomic cmpxchg() operation.
> 
> Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
