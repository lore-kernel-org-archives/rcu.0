Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D829A31C;
	Sun,  3 May 2026 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820178; cv=none; b=C142HOtyNjyvyoUVmkja+inCXk3wchTZ61z/qOTIp95La5cFuSGmjGh/JIXOFb6Rmj0/1mxpAhMRvj+c5oe09PD4dRv8PCvAA81IOISrn52d99wW0BTc5vf2pPTbLzMsgIVOZFtI+JMk6AT0vx19v6YFqkfBJaj8tRZizFcuqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820178; c=relaxed/simple;
	bh=od7THWqtZScmlfcYahIfLPvdd1bPkd9qQGltSz8BsZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IpZSGHMp5VhVkVhTM4m8TQbYzdo5S/xFVL8QurKaybL3ND8h4EpFPbqtU9XiJ7GFQQhTWNnVqEAY0omiOvfQmBz7mC7XOSTfPiiEKUdNc9uIKAKFfIzA10+44ph9yzKdaYR9SSsRqxtmK9F1nE5cT3Ge9V1SHRWpTtSh5X0lAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AZE4All2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AZE4All2"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A43DE41084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777820177; bh=1AKPIGhRNxK+F55Mad0JawX+0GWunrA5WkX6nSEFGLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AZE4All21O1rxm3+Fs4hD9srnEfVhetFdksjrOjV3VD83csa9mPQsIaE0wida9+9J
	 N+/xzjN768Ltum5SPW5NP76mL8D77ZLeuY3QwLSSpZWPmw7VTqr6LcLxxFsoyryih3
	 Cw7BRrH81/AYfcwvJ71axSfFI/4S7mM2rQAHBsZnKVA2mA+9rgikt6qRgqBgHa/ToH
	 SEOUJ3eoxda3ocAZisstFiiLSLe7COi99q7zzLDnR3vl8PISisuLK1ag43oadhDND3
	 Q6gvfwOjNy5JPuH747ES0aqGA8aejR+WZLmznez7o0Kb03gnnNKwpOq5obvRrNNsCm
	 1wUuJoEIqo0BQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A43DE41084;
	Sun,  3 May 2026 14:56:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebner@mailbox.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
 linux-sound@vger.kernel.org, rcu@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, Manuel Ebner
 <manuelebner@mailbox.org>
Subject: Re: [PATCH v4 0/3] Documentation: adopt new coding style of
 type-aware kmalloc-family
In-Reply-To: <20260429070759.309110-3-manuelebner@mailbox.org>
References: <20260429070759.309110-3-manuelebner@mailbox.org>
Date: Sun, 03 May 2026 08:56:13 -0600
Message-ID: <87o6iwczjm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebner@mailbox.org> writes:

> Update the documentation to reflect new type-aware kmalloc-family as
> suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
> and family")

OK, I have applied this series.  While doing so, I restored the "gfp"
parameter in the changelog portion where it had been mistakenly removed.

Thanks,

jon
