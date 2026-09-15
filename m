Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB68481FA1;
	Tue, 15 Sep 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491076; cv=none; b=jwuPA58Yj35eBdqpmQUzvIPtce2ol2pAwZjrQ+u+vlwCIaaboi3ZCF3YwK0o2fA+NDsq1mNh+I7dOaLBG2guCUVPFP8heEtBmtPruFZ9nmi46Aeb+wUvWXGWBuyUCMVED+9M5DXkVFMIQTIe9kx3b7oc0cly4PZ5gw5B9r+OsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491076; c=relaxed/simple;
	bh=KATSB6ChHF2lIHApGcxtoGi+oK4sluyqLkFLN7QNCKU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VzFOPsZ1ckkNLXL2qpQBaNWzuDtLtzuSn4Pw9210/HA7yfUQEfh6uPjigWYqZzpStvpxVdceuRF8LZWudnu6ovSre+G0PY6DQlxWPX3ZlxJeZJqG8MCAIl2e6cgzEQjm9DVZfCY8UCkTzq6uH9QjWSv9MUxKxleX2fZ+SpqH8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErJuhE5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErJuhE5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD051F000FF;
	Tue, 15 Sep 2026 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491074;
	bh=HL5UwWziwAl84fvTT7VlCgW4AGgrHMK0YvzN/v2w8LI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ErJuhE5dRFfCgXN+KTETkodZ36RXgAZE5we0jNuOu0L9gY+tUvLWqYFCptQVxFxLR
	 gTPAYyrYkZ7DgEU9dMpddZ4/sepYq2k3UGCDeqZIxoWoGXPV99G/r+/TMIOj3llkVg
	 2q2NpKR+LN7RbtrUWz3YcvpSs2Fh5PF9VttPrNFEyRNlnnGSh9n6Tb2Xe71xA+Oo4p
	 Qx9yO7FizU53k9ub6sBnhmZRCDScNPLYK5QmyWNbbBtG6kwBhLxVG8PanzSuHFE0pf
	 JPXfMPYX0gp7oxF3qoSeQFYP1CGZXYgJOdg4xWQENFtmm97lrSEtmhgBJhHl/bcwY3
	 XwIqRL2TEMZ/Q==
Content-Type: multipart/mixed; boundary="===============4851104051308731694=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a696904c51d47023b4dfabcf0a246ec9ed057a0dc8a286a21f042819b8568f05@mail.kernel.org>
In-Reply-To: <20260915154248.3612028-3-puranjay@kernel.org>
References: <20260915154248.3612028-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Add tests for bpf_call_rcu()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org,rcu@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,harry@kernel.org,paulmck@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 16:51:13 +0000 (UTC)

--===============4851104051308731694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
> new file mode 100644
> index 0000000000000..c2d266aee8eac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c

[ ... ]

> +void test_call_rcu(void)
> +{
> +	if (test__start_subtest("run"))
> +		test_call_rcu_run();
> +	if (test__start_subtest("chain"))
> +		test_call_rcu_chain();
> +	if (test__start_subtest("two_heads"))
> +		test_call_rcu_two_heads();
> +	if (test__start_subtest("teardown"))
> +		test_call_rcu_teardown();
> +	if (test__start_subtest("hash_map"))
> +		test_call_rcu_bad_map();
> +	if (test__start_subtest("iter"))
> +		test_call_rcu_iter();
> +	if (test__start_subtest("inner_map"))
> +		test_call_rcu_inner_map();
> +	RUN_TESTS(call_rcu_fail);
> +}

This isn't a bug, but would renaming test_call_rcu_bad_map() to
test_call_rcu_hash_map() (or renaming the subtest to "bad_map") keep the
name/subtest pairing consistent?  Every other subtest string here mirrors
its helper's suffix - "run"/test_call_rcu_run,
"chain"/test_call_rcu_chain, "two_heads"/test_call_rcu_two_heads,
"teardown"/test_call_rcu_teardown, "iter"/test_call_rcu_iter,
"inner_map"/test_call_rcu_inner_map.  Only "hash_map" is paired with
test_call_rcu_bad_map(), so grepping for a failing subtest name doesn't
land on its implementation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34991517047
--===============4851104051308731694==--
