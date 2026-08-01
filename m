Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D941E7C18;
	Sat,  1 Aug 2026 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588694; cv=none; b=ll5C+fH511x8iUkqOCMos3hyFL/bgSnYwypKg5s2emi/LC/CAmFjRROH8R0g6QCxhwrINeY8osVm1mbyeEvTbiE5rRDFkIkUnq4t07KlWOEPxzXKydL5QEhLEk2L3gMmeVPUPm7M1/n1pkVqH2YE6rFe+26yO261GhcKLuYmbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588694; c=relaxed/simple;
	bh=oLKIWdPjaxG7pkA6+onimo4kYOyBAeuGePHSbnUeIUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpTtIpsxeK1aEAr5adVfUFrT6S08VzVXNhJ0xNy7D8xHWxpu4XqCI8VCpXD2Sy+AaxGfDdKKHXsDsPDLGynmeYRy2MwjD1v32dJqid8NttKrS8jPE2JMqvJFFhcF47S7j44Y3nsQBf6WM3POQEf04eOyB2oXa9tCnqtB+9NQmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIgqcCL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIgqcCL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9381F00AC4;
	Sat,  1 Aug 2026 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588693;
	bh=YnwFawdRZh+GCy4YU8vannLc+3WGfD1ePfzk8ZSjrGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OIgqcCL0PvJPjSEB89T2YhZ7wsGRXICq3P0Yase6pgJudXZuld1aUJBLqjid/r4YH
	 4CJcg3vzVK79nDg7W9Q6oUdlb06+SGD8y4TZtrh1+lQ05BerwiUK0Ur/LpOo/72lg5
	 P8CLDunox8lkMrSQVUc67mFrDYSRSDon1mWoEBYn2/w/iT0rgyPAaBfw4X9KUDu3Bx
	 6+pk9oev8+HwNVKudmq6FgZR4BLSGtJNazOOQphfnjIyxSa/NouQDs78APo+mAi7Kq
	 hrlp6K/Lxko1zti9cPFtSPXCGbvJOu90WGC8abxeLeT2jAbHizvi/rqmSkfuGk5RF2
	 YJN5/4WHtgvWA==
Date: Sat, 1 Aug 2026 21:51:30 +0900
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
Message-ID: <am3ruh9vviTIa5cK@thinkpad>
References: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>

On Thu, Jul 30, 2026 at 04:32:46PM +0200, Vlastimil Babka (SUSE) wrote:
> No module code calls these functions directly. Seems it was always the
> case. Remove the exports.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
