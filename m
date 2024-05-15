Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C303FE55;
	Wed, 15 May 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814789; cv=none; b=X9EK1PbDMmwCrXBGcZnZ1pIplpIaWnhmcgAvi2DrdchRyMShr/Sg8Uoc074eL3I6EFLaEKxuzE1sgAq1XdRxObyd1hRcvP7nWprMCDe/s8csabZX//XgUAkQ0R17Gv7zKuPLdtlw5oUP43M5v3Oyutj2fLBf/d5/yF/D3Q7H7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814789; c=relaxed/simple;
	bh=tlYnJ6olUNp1zacCHP/agUcn9KLHHKuiqQyPre8rQ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEmiQ/e6+JwbAQjdtc2AFYMko5VbKou5gGoUFJ8wya9aQ1zh1tfLocyrP+BfoRvDUCUqCX2w6u6OEQDvLgnTOZohmADtYf7X0VfV1uM3aAEETwdouWkRG3PKH30IrkLb91HpApx3/uShRWmfO2/f5XMyqNwObHZbrf5AHle3pfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apKN5I5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apKN5I5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D94C116B1;
	Wed, 15 May 2024 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715814789;
	bh=tlYnJ6olUNp1zacCHP/agUcn9KLHHKuiqQyPre8rQ0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apKN5I5mrxkyatSHkY7fSeVdeTt1+PIvRaJtPs0EsGbcJqbNBImw7iVt8tbEEoZzG
	 KaOvLhF7hd8qUqtWJneKISNXeksgtxha3iPqI4eAbdTJPfipMY5JKDbIyFMh8SEC8O
	 wHuwl+Klu2MKuOktp3Z97xv924mRSzKC2wtHlhdlMqM+UpbmAza/1L11T1NROuEeYi
	 faMjU9a+SIvTzyF7Kr89SEKCxA46+pxY/nOtFuys0UKtAx+ZWtdtFnhgezCOmPQMwL
	 h0oUAo50uKLqdlmS/TFcLrkTkR1hNpkCUHX4eXZpi4pnE6BU4y2RllshSldgUzQzUY
	 3OeqYq/m8XIqQ==
Date: Thu, 16 May 2024 01:13:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/6] rcu: Remove several redundant memory barriers
Message-ID: <ZkVBgs0J7egyBgXR@pavilion.home>
References: <20240515125332.9306-1-frederic@kernel.org>
 <xhsmhjzjvgevl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhjzjvgevl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, May 15, 2024 at 07:32:30PM +0200, Valentin Schneider a écrit :
> On 15/05/24 14:53, Frederic Weisbecker wrote:
> > Reviewing Valentin's patchset made me stare at some memory barriers
> > on the way.
> 
> Sorry not sorry? :-)

;-))
