Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E316C8F0;
	Wed, 22 Jan 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505489; cv=none; b=Dz21061hMVzS8RakaCIaju37vx1B1VmfJaf1vzixByoYoPDSCXvRGwpvmI8Rof0md3C1qrQn+sHQg3emUFn1Lcz6YMlK9ac3SXY51xZnOwb+XLu2kItfsyljiwgYjK7MFiWIBTpm+m/Xb0Ac4P3/huZrDFRn59BOwCRp1eFk34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505489; c=relaxed/simple;
	bh=3ac1cyLLhZIUux34A72D157czd3J/rzzgYp37fOxvFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orFOsSdWdIYb9nIi4IBltXUm+Qk9Jv2kOWlDhfHhwwNbtZaNyXBzUj0NX9GG++TxoCfA6/3+7EFAeueC5W6wOmrgi/4YKrUrs5AymqH4JeExgxztW0FJJoXsgAVMCe35vsXBcUToldjSLze3R7bWgEp0rOCgTj1T8V3CRLdRkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb22Hu3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb22Hu3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB6DC4CEDF;
	Wed, 22 Jan 2025 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737505489;
	bh=3ac1cyLLhZIUux34A72D157czd3J/rzzgYp37fOxvFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb22Hu3RMhMxZUFBaTC4uMYkDQ3PH9MvL1+XhZMT9QsURTmxcYwI7T/bh6BBlOnEJ
	 pnpR5fxSr2ugw6OlsiGPS+5V2pNsDhZRhgf75cYM0ChB6eVq99uaz+E4KesKO8swxk
	 fZJ5oXur8Lx073AXAZH4cZoF4EpAKF0N47na9iIGX85dX4dw6xOu5fU6jscM4KtfST
	 xcyt0lg54EJD9QooSIQSJRDFOQqQX1qYYvH1e/ZhnhpEc2lyhZC9HIIJ+o+mQaFYdJ
	 1Vm6iNnLUBed8Zr13fc35TcmEOX2WAulQ6hOIrQO/pDglp31JjoSbGGM/Nm6GU244i
	 jouJxqLL120rw==
Date: Tue, 21 Jan 2025 19:24:47 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>
Subject: Re: [GIT PULL] slab updates for 6.14
Message-ID: <Z5A6z8l6-tgzPY0R@lappy>
References: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
 <Z46N0lAqUwQ3Z5S6@lappy>
 <004f6d81-cfa2-aeb0-6054-cb745154eeaf@gentwo.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <004f6d81-cfa2-aeb0-6054-cb745154eeaf@gentwo.org>

On Tue, Jan 21, 2025 at 03:53:37PM -0800, Christoph Lameter (Ampere) wrote:
>On Mon, 20 Jan 2025, Sasha Levin wrote:
>
>> I've ended up pulling quite a few of the 6.14 PRs into linus-next, and
>> LKFT started hitting the following issue:
>
>Could you reboot with the parameter "slub_debug" to get more information
>in the syslog?

Sorry for the lack of updates here. I've bisected it, and it turned out
to be an issue with the tracing PR that Steve sent a fix for: https://lore.kernel.org/all/Z4_OHKESRSiJcr-b@lappy/

-- 
Thanks,
Sasha
