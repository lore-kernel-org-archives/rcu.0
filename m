Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3789475;
	Sat, 17 Jan 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768663022; cv=none; b=JtschMnJO0OVPy9m8gucV4E7RNdtMDzpBNUfEmovfE0UUaeDs+vzWpKvlF+g0HH5OBZpN+YdtI9FqmWAbp0PRe7cJbXi38QkHOnYKCj4rc2uBLJE4lmPUGrwe+OZvl4Ol0xhF5usP4cGrrQn3ybJvKvWdDW4WEhNI2Du8Zk7rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768663022; c=relaxed/simple;
	bh=4Eo9rL5VezG91QH7IFGeFhyF/UQyKRq41t4Vf31FAiw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VhZKA+ZaMajks33kJ1t54nGiQZsGzKDIPWAamHiuN1TBfLM3MoX7B/RIHhPLUIaap1TA0sLgL2TVxke0wSkHmm07xFHXbBkm1ZppDd3HFWRe/fImcNrqoPY7LPcoBNgRA9dVZUHFVV8r4miIOPyqeBNiEKbqcbgLCPpKLV2GiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FdXV6ll5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FdXV6ll5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768663007; x=1769267807; i=markus.elfring@web.de;
	bh=4Eo9rL5VezG91QH7IFGeFhyF/UQyKRq41t4Vf31FAiw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FdXV6ll5MitmK0l7bnj9DINYb9k1az+9tq86B8wm1sIkTMj1wPvCir8QJOdC5POE
	 Ezeph5G40QeEDwCl98S7pyLvWaxueaeuHMIpWGQOfBqaldcrtBiGPosaNxf1sSkYK
	 Xf5D8I72BmKmGenO4BO7CmvdHjZMayoc94rcf9W+Fg5dWzFyMgWbAQ1hI0jyTbOmC
	 NmGM+MjZDsEZnb9wsizlZUVKagGU54tZFjyt5A0ZRjKQfUlb9Nh9zuJZJyQPCZwjN
	 wJ57PwZSjT276N6WtyR4nrMlGpYwzYNmtP1ehsGMwAdGdjtqWh4URfvSIo9loQ+fV
	 FmAMJ50LszyG6Nurcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1vhwr428rV-001Nxd; Sat, 17
 Jan 2026 16:16:47 +0100
Message-ID: <623303af-71b9-421f-b694-32807e541a5b@web.de>
Date: Sat, 17 Jan 2026 16:16:45 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>
References: <20260114183415.286489-1-urezki@gmail.com>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260114183415.286489-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMkwJQkJ1qRGqSgBTzgk+sbqbERBNYHwJiIVdxGN87NT7CfjbOI
 lg3R3A09eWshuaiG8t3OWV3i8mcCf5j34Pj2gOBas/+CitdDaBfztnmnE7Z0l/ComKkIhWl
 NuCvAVxYA9WcURDvA14qY2w+FiA1HCUr9BhHP6tog5Lal8l1mYFh7+dNWWKI6TO5zTtIss/
 OvsJ1eqP3BrurungGkYnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BFK0v6uMWDc=;bixKjJpPrkcoF6KT3CnyiMxpAuj
 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
 0Ue+1b+s=

=E2=80=A6
> This patch introduces =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

Regards,
Markus
