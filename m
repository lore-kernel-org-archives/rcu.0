Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AA1F1912;
	Tue, 21 Jan 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737503626; cv=none; b=o4+NlqOMM7RUGWlUloXU9CXrTw8XInKQqNCok/W4PJwa91IrRe5wWD585T+2vyNY3wLXFNhI/Y1WUu2XN06F0R8s6SkPryvXX5EYwSw0RTaGNdJ4H8592TtFETm84Ea8coWYRMlXe34DMDCkgHrHsoWO1NycSwmyxxslsMUrLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737503626; c=relaxed/simple;
	bh=YeqpILrtuuSPA0grw39/Uw+Qc+LqzqjlGCtY0EwRlD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eALDWBmWsoUplUTxbs1OsBreszyewB9oaR+3UOC87s2hpU/nVuuO9gXhrsT85RPJkcEDfS77dI40BX9O+sLkE1HIGJKDZk6RyrlRDon8SZDr53jaBYCHqn+kPWkOXTUeNX0EHsOa19OoOZokvtnMqdHiFk37tS5X9zVBlhu5WE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=XRZ7H3+f; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="XRZ7H3+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1737503617;
	bh=YeqpILrtuuSPA0grw39/Uw+Qc+LqzqjlGCtY0EwRlD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XRZ7H3+fC6tCaooogvwChYV2PDoN+srhCR+SPlbn3WaTadNBKbCRW2jbxF30JH6J8
	 ws2YgXOGNEQwkjJLBTBkICb71pT6LLH1gVGIWfJRNQ3ElhwYNMdGl5pqdKlwUEagcz
	 cNbPHdqdAIONVvm2AyLVoQnO2Akau8ZIBhfFI3+c=
Received: by gentwo.org (Postfix, from userid 1003)
	id 5187B401F3; Tue, 21 Jan 2025 15:53:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 4E900401E1;
	Tue, 21 Jan 2025 15:53:37 -0800 (PST)
Date: Tue, 21 Jan 2025 15:53:37 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Sasha Levin <sashal@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    David Rientjes <rientjes@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [GIT PULL] slab updates for 6.14
In-Reply-To: <Z46N0lAqUwQ3Z5S6@lappy>
Message-ID: <004f6d81-cfa2-aeb0-6054-cb745154eeaf@gentwo.org>
References: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz> <Z46N0lAqUwQ3Z5S6@lappy>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jan 2025, Sasha Levin wrote:

> I've ended up pulling quite a few of the 6.14 PRs into linus-next, and
> LKFT started hitting the following issue:

Could you reboot with the parameter "slub_debug" to get more information
in the syslog?

