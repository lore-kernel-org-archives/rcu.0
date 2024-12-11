Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607681D6DDA;
	Wed, 11 Dec 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933529; cv=none; b=TZr7AXebqZ0X15oh9IsjKPsdmvaLX+GDJoK8PgbfB5WO8pauDsbskpR8RTfuERg1pyj4vWqDXffEkc66MDvbqPFbrn5N3lyG9lkwFfMsuHNASEC86exdUR1vDhmaM63Hamcf1u3fAB9nsUuBvl0u6eNR9AVixVTobyf9ThzfVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933529; c=relaxed/simple;
	bh=DqM4wCTUO4f59fvNBwQ8cFCi83F+Kt7OieUpfQQZmpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbGIYqEnvsWngQOfSfugdqB0xRS1nnpYlIcbr01qKddNm5TybQXfLuiX2V1jrtDuwRXnaDDlyXsJWlbydGkdNf5XkU3J+NCeHlfJL5juOA/raVM1P80eq0v2A7v2EjYK1N2ZWRr+GLfvrW44TyZI93TpZ5iNEnIJX3vhXvjkOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg10jpqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg10jpqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D383AC4CED2;
	Wed, 11 Dec 2024 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733933528;
	bh=DqM4wCTUO4f59fvNBwQ8cFCi83F+Kt7OieUpfQQZmpU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mg10jpqbk9V8zSR7Ud4yFygPi27WtWtitQ7HOXMr5weZZYKKNzVbrAyBHBAYctYYh
	 4fglQwzX8S8GzmQRACOIvtFevI5WDfOTKsr8aKu3agoboMclf9Ocqxgsw28HA47CJx
	 vPvpnH/RKRD+gYZ3lP9WqYGTj+0Od0TeT8SEU8VcV8cL0s7oxbowaGpCsqHBbE4pA+
	 uF5PFKITPCf05qdDDDCl3OJ+hZ7FJ+IuP8oXoGYPOb9zKMdti0OvhzJMT55ZgGE93D
	 hq7LmZaZdqXXEk7QhPwJneNLf22sHXRHebnRs/k9q/uV0o8RCFta/LgB7Rv9ATqHSM
	 aIJvB/a9CoKrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7CA5FCE0EE1; Wed, 11 Dec 2024 08:12:08 -0800 (PST)
Date: Wed, 11 Dec 2024 08:12:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [RFC v1 0/5] Move kvfree_rcu() into SLAB
Message-ID: <bd3f3892-c3a8-42c7-a42a-aa0acd316985@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241210164035.3391747-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210164035.3391747-1-urezki@gmail.com>

On Tue, Dec 10, 2024 at 05:40:30PM +0100, Uladzislau Rezki (Sony) wrote:
> Hello!
> 
> This series is based on v6.12 kernel. It is an attempt to move the kvfree_rcu()
> into MM from the kernel/rcu/ place. I split the series into a few patches so it
> is easier to follow a migration process.
> 
> As a result of this series, the main functionality is located under MM.
> 
> Uladzislau Rezki (Sony) (5):

Tested-by: Paul E. McKenney <paulmck@kernel.org>

>   rcu/kvfree: Temporary reclaim over call_rcu()
>   mm/slab: Copy main data structures of kvfree_rcu()
>   mm/slab: Copy internal functions of kvfree_rcu()
>   mm/slab: Copy a function of kvfree_rcu() initialization
>   mm/slab: Move kvfree_rcu() into SLAB
> 
>  include/linux/slab.h |   1 +
>  init/main.c          |   1 +
>  kernel/rcu/tree.c    | 866 ------------------------------------------
>  mm/slab_common.c     | 875 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 877 insertions(+), 866 deletions(-)
> 
> -- 
> 2.39.5
> 
> 
> 
